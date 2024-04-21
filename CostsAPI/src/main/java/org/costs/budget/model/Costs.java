package org.costs.budget.model;

import java.math.BigDecimal;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;


@Document("costs")
public class Costs {
    @Id
    private String id;

    @Field(name="name")
    @Indexed(unique = true)
    private String costsName;
    @Field(name="category")

    private CostsCategory costsCategory;
    @Field(name="amount")

    private BigDecimal costsAmount;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCostsName() {
        return costsName;
    }

    public void setCostsName(String costsName) {
        this.costsName = costsName;
    }

    public CostsCategory getCostsCategory() {
        return costsCategory;
    }

    public void setCostsCategory(CostsCategory costsCategory) {
        this.costsCategory = costsCategory;
    }

    public BigDecimal getCostsAmount() {
        return costsAmount;
    }

    public void setCostsAmount(BigDecimal costsAmount) {
        this.costsAmount = costsAmount;
    }

    public Costs(String id, String costsName, CostsCategory costsCategory, BigDecimal costsAmount){
        this.id=id;
        this.costsName=costsName;
        this.costsCategory=costsCategory;
        this.costsAmount=costsAmount;


    }

}
