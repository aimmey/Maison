/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author aimmy
 */
@Entity
@Table(name = "PRODUCT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p")
    , @NamedQuery(name = "Product.findByProductid", query = "SELECT p FROM Product p WHERE p.productid = :productid")
    , @NamedQuery(name = "Product.findByProductname", query = "SELECT p FROM Product p WHERE p.productname = :productname")
    , @NamedQuery(name = "Product.findByProductdetail", query = "SELECT p FROM Product p WHERE p.productdetail = :productdetail")
    , @NamedQuery(name = "Product.findByProductWidth", query = "SELECT p FROM Product p WHERE p.productWidth = :productWidth")
    , @NamedQuery(name = "Product.findByProductLength", query = "SELECT p FROM Product p WHERE p.productLength = :productLength")
    ,@NamedQuery(name = "Product.SearchByName", query = "SELECT p FROM Product p WHERE upper(p.productname)"
            + " like upper(:search)")
    , @NamedQuery(name = "Product.findByProductHeight", query = "SELECT p FROM Product p WHERE p.productHeight = :productHeight")
    , @NamedQuery(name = "Product.findByPrice", query = "SELECT p FROM Product p WHERE p.price = :price")})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "PRODUCTID")
    private String productid;
    @Size(max = 20)
    @Column(name = "PRODUCTNAME")
    private String productname;
    @Size(max = 500)
    @Column(name = "PRODUCTDETAIL")
    private String productdetail;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "PRODUCT_WIDTH")
    private Double productWidth;
    @Column(name = "PRODUCT_LENGTH")
    private Double productLength;
    @Column(name = "PRODUCT_HEIGHT")
    private Double productHeight;
    @Column(name = "PRICE")
    private Double price;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "product")
    private Productlines productlines;

    public Product() {
    }

    public Product(String productid) {
        this.productid = productid;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getProductdetail() {
        return productdetail;
    }

    public void setProductdetail(String productdetail) {
        this.productdetail = productdetail;
    }

    public Double getProductWidth() {
        return productWidth;
    }

    public void setProductWidth(Double productWidth) {
        this.productWidth = productWidth;
    }

    public Double getProductLength() {
        return productLength;
    }

    public void setProductLength(Double productLength) {
        this.productLength = productLength;
    }

    public Double getProductHeight() {
        return productHeight;
    }

    public void setProductHeight(Double productHeight) {
        this.productHeight = productHeight;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Productlines getProductlines() {
        return productlines;
    }

    public void setProductlines(Productlines productlines) {
        this.productlines = productlines;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productid != null ? productid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.productid == null && other.productid != null) || (this.productid != null && !this.productid.equals(other.productid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Product[ productid=" + productid + " ]";
    }

}
