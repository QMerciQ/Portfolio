package org.costs.budget.service;

import org.costs.budget.model.Costs;
import org.costs.budget.repository.CostsRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CostsService {
    private final CostsRepository costsRepository;
    public CostsService(CostsRepository costsRepository){
        this.costsRepository=costsRepository;
    }

    public void addCosts(Costs costs){
        costsRepository.insert(costs);
    }
    public void updateCosts(Costs costs){
        Costs savedCosts = costsRepository.findById(costs.getId())
                .orElseThrow(()->new RuntimeException(
                        String.format("Cannout Find Costs by ID %s", costs.getId())
                ));

        savedCosts.setCostsName(costs.getCostsName());
        savedCosts.setCostsCategory(costs.getCostsCategory());
        savedCosts.setCostsAmount(costs.getCostsAmount());

        costsRepository.save(costs);

    }
    public List<Costs> getAllCosts(){
        return costsRepository.findAll();
    }
    public Costs getCostsByName(String name){
        return costsRepository.findByName(name).orElseThrow(()->new RuntimeException(
                String.format("Cannot Find Costs by Name %s", name)
        ));
    }
    public void deleteCosts(String id){
        costsRepository.deleteById(id);

    }
}
