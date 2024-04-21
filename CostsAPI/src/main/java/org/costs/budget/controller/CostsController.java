package org.costs.budget.controller;


import org.costs.budget.service.CostsService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.costs.budget.model.Costs;

import java.util.List;

@RestController
@RequestMapping("/api/costs")
public class CostsController {

    private final CostsService costsService;
    public CostsController(CostsService costsService){
        this.costsService=costsService;
    }

    @PostMapping
    public ResponseEntity addCosts(@RequestBody Costs costs){
        costsService.addCosts(costs);
        return ResponseEntity.status(HttpStatus.CREATED).build();

    }

    @PutMapping
    public ResponseEntity updateCosts(@RequestBody Costs costs){
        costsService.updateCosts(costs);
        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<List<Costs>> getAllCosts(){
        return ResponseEntity.ok(costsService.getAllCosts());
    }

    @GetMapping("/{name}")
    public ResponseEntity<Costs> getCostsByName(@PathVariable String name){
        return ResponseEntity.ok(costsService.getCostsByName(name));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity deleteCosts(@PathVariable String id){
        costsService.deleteCosts(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();

    }
}
