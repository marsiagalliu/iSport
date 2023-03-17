package com.dojo.isport.repositories;

import com.dojo.isport.models.Event;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventRepository extends CrudRepository<Event, Long> {

    List<Event> findAll();
    List<Event> findByEventName(String EventName);
}
