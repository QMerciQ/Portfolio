package org.costs.budget.repository;


import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.costs.budget.model.Costs;


import java.util.Optional;

public interface CostsRepository extends MongoRepository<Costs, String> {
    @Query("{'name': ?0}")
    Optional<Costs> findByName(String name);

}
