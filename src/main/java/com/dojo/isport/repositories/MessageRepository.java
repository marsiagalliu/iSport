package com.dojo.isport.repositories;

import com.dojo.isport.models.Message;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {

    List<Message> findAll();

    List<Message> findAllByEventId(Long id);
}
