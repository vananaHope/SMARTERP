package com.web.erp.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.web.erp.entity.Store;


public interface StoreRepository extends JpaRepository<Store, Long> {
	@Query("SELECT s FROM Store s "
			+ "WHERE s.store_name LIKE %:#{#sch.store_name}% "
			+ "AND s.city LIKE %:#{#sch.city}% ")
	List<Store> findByNameAndCity(@Param("sch") Store sch);
	
	@Query("SELECT DISTINCT s.city FROM Store s")
	List<String> findDistinctCities();
}
