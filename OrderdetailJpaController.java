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
import model.Orders;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;
import model.Orderdetail;

/**
 *
 * @author aimmy
 */
public class OrderdetailJpaController implements Serializable {

    public OrderdetailJpaController(UserTransaction utx, EntityManagerFactory emf) {
        this.utx = utx;
        this.emf = emf;
    }
    private UserTransaction utx = null;
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Orderdetail orderdetail) throws IllegalOrphanException, PreexistingEntityException, RollbackFailureException, Exception {
        List<String> illegalOrphanMessages = null;
        Orders ordersOrphanCheck = orderdetail.getOrders();
        if (ordersOrphanCheck != null) {
            Orderdetail oldOrderdetailOfOrders = ordersOrphanCheck.getOrderdetail();
            if (oldOrderdetailOfOrders != null) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("The Orders " + ordersOrphanCheck + " already has an item of type Orderdetail whose orders column cannot be null. Please make another selection for the orders field.");
            }
        }
        if (illegalOrphanMessages != null) {
            throw new IllegalOrphanException(illegalOrphanMessages);
        }
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Orders orders = orderdetail.getOrders();
            if (orders != null) {
                orders = em.getReference(orders.getClass(), orders.getOrderid());
                orderdetail.setOrders(orders);
            }
            em.persist(orderdetail);
            if (orders != null) {
                orders.setOrderdetail(orderdetail);
                orders = em.merge(orders);
            }
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findOrderdetail(orderdetail.getOrderid()) != null) {
                throw new PreexistingEntityException("Orderdetail " + orderdetail + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Orderdetail orderdetail) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Orderdetail persistentOrderdetail = em.find(Orderdetail.class, orderdetail.getOrderid());
            Orders ordersOld = persistentOrderdetail.getOrders();
            Orders ordersNew = orderdetail.getOrders();
            List<String> illegalOrphanMessages = null;
            if (ordersNew != null && !ordersNew.equals(ordersOld)) {
                Orderdetail oldOrderdetailOfOrders = ordersNew.getOrderdetail();
                if (oldOrderdetailOfOrders != null) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("The Orders " + ordersNew + " already has an item of type Orderdetail whose orders column cannot be null. Please make another selection for the orders field.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (ordersNew != null) {
                ordersNew = em.getReference(ordersNew.getClass(), ordersNew.getOrderid());
                orderdetail.setOrders(ordersNew);
            }
            orderdetail = em.merge(orderdetail);
            if (ordersOld != null && !ordersOld.equals(ordersNew)) {
                ordersOld.setOrderdetail(null);
                ordersOld = em.merge(ordersOld);
            }
            if (ordersNew != null && !ordersNew.equals(ordersOld)) {
                ordersNew.setOrderdetail(orderdetail);
                ordersNew = em.merge(ordersNew);
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
                String id = orderdetail.getOrderid();
                if (findOrderdetail(id) == null) {
                    throw new NonexistentEntityException("The orderdetail with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Orderdetail orderdetail;
            try {
                orderdetail = em.getReference(Orderdetail.class, id);
                orderdetail.getOrderid();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The orderdetail with id " + id + " no longer exists.", enfe);
            }
            Orders orders = orderdetail.getOrders();
            if (orders != null) {
                orders.setOrderdetail(null);
                orders = em.merge(orders);
            }
            em.remove(orderdetail);
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

    public List<Orderdetail> findOrderdetailEntities() {
        return findOrderdetailEntities(true, -1, -1);
    }

    public List<Orderdetail> findOrderdetailEntities(int maxResults, int firstResult) {
        return findOrderdetailEntities(false, maxResults, firstResult);
    }

    private List<Orderdetail> findOrderdetailEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Orderdetail.class));
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

    public Orderdetail findOrderdetail(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Orderdetail.class, id);
        } finally {
            em.close();
        }
    }

    public int getOrderdetailCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Orderdetail> rt = cq.from(Orderdetail.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
