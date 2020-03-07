/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import controller.exceptions.IllegalOrphanException;
import controller.exceptions.NonexistentEntityException;
import controller.exceptions.PreexistingEntityException;
import controller.exceptions.RollbackFailureException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import model.Customer;
import model.Orderdetail;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;
import model.Orders;

/**
 *
 * @author aimmy
 */
public class OrdersJpaController implements Serializable {

    public OrdersJpaController(UserTransaction utx, EntityManagerFactory emf) {
        this.utx = utx;
        this.emf = emf;
    }
    private UserTransaction utx = null;
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Orders orders) throws PreexistingEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Customer customerid = orders.getCustomerid();
            if (customerid != null) {
                customerid = em.getReference(customerid.getClass(), customerid.getCustomerid());
                orders.setCustomerid(customerid);
            }
            Orderdetail orderdetail = orders.getOrderdetail();
            if (orderdetail != null) {
                orderdetail = em.getReference(orderdetail.getClass(), orderdetail.getOrderid());
                orders.setOrderdetail(orderdetail);
            }
            em.persist(orders);
            if (customerid != null) {
                customerid.getOrdersList().add(orders);
                customerid = em.merge(customerid);
            }
            if (orderdetail != null) {
                Orders oldOrdersOfOrderdetail = orderdetail.getOrders();
                if (oldOrdersOfOrderdetail != null) {
                    oldOrdersOfOrderdetail.setOrderdetail(null);
                    oldOrdersOfOrderdetail = em.merge(oldOrdersOfOrderdetail);
                }
                orderdetail.setOrders(orders);
                orderdetail = em.merge(orderdetail);
            }
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findOrders(orders.getOrderid()) != null) {
                throw new PreexistingEntityException("Orders " + orders + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Orders orders) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Orders persistentOrders = em.find(Orders.class, orders.getOrderid());
            Customer customeridOld = persistentOrders.getCustomerid();
            Customer customeridNew = orders.getCustomerid();
            Orderdetail orderdetailOld = persistentOrders.getOrderdetail();
            Orderdetail orderdetailNew = orders.getOrderdetail();
            List<String> illegalOrphanMessages = null;
            if (orderdetailOld != null && !orderdetailOld.equals(orderdetailNew)) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("You must retain Orderdetail " + orderdetailOld + " since its orders field is not nullable.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (customeridNew != null) {
                customeridNew = em.getReference(customeridNew.getClass(), customeridNew.getCustomerid());
                orders.setCustomerid(customeridNew);
            }
            if (orderdetailNew != null) {
                orderdetailNew = em.getReference(orderdetailNew.getClass(), orderdetailNew.getOrderid());
                orders.setOrderdetail(orderdetailNew);
            }
            orders = em.merge(orders);
            if (customeridOld != null && !customeridOld.equals(customeridNew)) {
                customeridOld.getOrdersList().remove(orders);
                customeridOld = em.merge(customeridOld);
            }
            if (customeridNew != null && !customeridNew.equals(customeridOld)) {
                customeridNew.getOrdersList().add(orders);
                customeridNew = em.merge(customeridNew);
            }
            if (orderdetailNew != null && !orderdetailNew.equals(orderdetailOld)) {
                Orders oldOrdersOfOrderdetail = orderdetailNew.getOrders();
                if (oldOrdersOfOrderdetail != null) {
                    oldOrdersOfOrderdetail.setOrderdetail(null);
                    oldOrdersOfOrderdetail = em.merge(oldOrdersOfOrderdetail);
                }
                orderdetailNew.setOrders(orders);
                orderdetailNew = em.merge(orderdetailNew);
            }
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = orders.getOrderid();
                if (findOrders(id) == null) {
                    throw new NonexistentEntityException("The orders with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Orders orders;
            try {
                orders = em.getReference(Orders.class, id);
                orders.getOrderid();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The orders with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Orderdetail orderdetailOrphanCheck = orders.getOrderdetail();
            if (orderdetailOrphanCheck != null) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Orders (" + orders + ") cannot be destroyed since the Orderdetail " + orderdetailOrphanCheck + " in its orderdetail field has a non-nullable orders field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Customer customerid = orders.getCustomerid();
            if (customerid != null) {
                customerid.getOrdersList().remove(orders);
                customerid = em.merge(customerid);
            }
            em.remove(orders);
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Orders> findOrdersEntities() {
        return findOrdersEntities(true, -1, -1);
    }

    public List<Orders> findOrdersEntities(int maxResults, int firstResult) {
        return findOrdersEntities(false, maxResults, firstResult);
    }

    private List<Orders> findOrdersEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Orders.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Orders findOrders(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Orders.class, id);
        } finally {
            em.close();
        }
    }

    public int getOrdersCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Orders> rt = cq.from(Orders.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
