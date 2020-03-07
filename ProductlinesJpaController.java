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
import model.Product;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;
import model.Productlines;

/**
 *
 * @author aimmy
 */
public class ProductlinesJpaController implements Serializable {

    public ProductlinesJpaController(UserTransaction utx, EntityManagerFactory emf) {
        this.utx = utx;
        this.emf = emf;
    }
    private UserTransaction utx = null;
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Productlines productlines) throws IllegalOrphanException, PreexistingEntityException, RollbackFailureException, Exception {
        List<String> illegalOrphanMessages = null;
        Product productOrphanCheck = productlines.getProduct();
        if (productOrphanCheck != null) {
            Productlines oldProductlinesOfProduct = productOrphanCheck.getProductlines();
            if (oldProductlinesOfProduct != null) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("The Product " + productOrphanCheck + " already has an item of type Productlines whose product column cannot be null. Please make another selection for the product field.");
            }
        }
        if (illegalOrphanMessages != null) {
            throw new IllegalOrphanException(illegalOrphanMessages);
        }
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Product product = productlines.getProduct();
            if (product != null) {
                product = em.getReference(product.getClass(), product.getProductid());
                productlines.setProduct(product);
            }
            em.persist(productlines);
            if (product != null) {
                product.setProductlines(productlines);
                product = em.merge(product);
            }
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findProductlines(productlines.getProductid()) != null) {
                throw new PreexistingEntityException("Productlines " + productlines + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Productlines productlines) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Productlines persistentProductlines = em.find(Productlines.class, productlines.getProductid());
            Product productOld = persistentProductlines.getProduct();
            Product productNew = productlines.getProduct();
            List<String> illegalOrphanMessages = null;
            if (productNew != null && !productNew.equals(productOld)) {
                Productlines oldProductlinesOfProduct = productNew.getProductlines();
                if (oldProductlinesOfProduct != null) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("The Product " + productNew + " already has an item of type Productlines whose product column cannot be null. Please make another selection for the product field.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (productNew != null) {
                productNew = em.getReference(productNew.getClass(), productNew.getProductid());
                productlines.setProduct(productNew);
            }
            productlines = em.merge(productlines);
            if (productOld != null && !productOld.equals(productNew)) {
                productOld.setProductlines(null);
                productOld = em.merge(productOld);
            }
            if (productNew != null && !productNew.equals(productOld)) {
                productNew.setProductlines(productlines);
                productNew = em.merge(productNew);
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
                String id = productlines.getProductid();
                if (findProductlines(id) == null) {
                    throw new NonexistentEntityException("The productlines with id " + id + " no longer exists.");
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
            Productlines productlines;
            try {
                productlines = em.getReference(Productlines.class, id);
                productlines.getProductid();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The productlines with id " + id + " no longer exists.", enfe);
            }
            Product product = productlines.getProduct();
            if (product != null) {
                product.setProductlines(null);
                product = em.merge(product);
            }
            em.remove(productlines);
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

    public List<Productlines> findProductlinesEntities() {
        return findProductlinesEntities(true, -1, -1);
    }

    public List<Productlines> findProductlinesEntities(int maxResults, int firstResult) {
        return findProductlinesEntities(false, maxResults, firstResult);
    }

    private List<Productlines> findProductlinesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Productlines.class));
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

    public Productlines findProductlines(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Productlines.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductlinesCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Productlines> rt = cq.from(Productlines.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
