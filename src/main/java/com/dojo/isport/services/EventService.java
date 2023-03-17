package com.dojo.isport.services;

import com.dojo.isport.models.Event;
import com.dojo.isport.repositories.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EventService {

    @Autowired
    EventRepository eventRepository;

    public List<Event> allEvents() {return eventRepository.findAll();
    }

    public Event createEvent(Event event) {
        return eventRepository.save(event);
    }

    public Event findEvent(Long id) {
        Optional<Event> optionalEvent = eventRepository.findById(id);
        if(optionalEvent.isPresent()) {
            return optionalEvent.get();
        } else {
            return null;
        }
    }

    public Event updateEvent(Event event) {
        return eventRepository.save(event);
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }

    public List<Event> findByName(String EventName){
        return eventRepository.findByEventName(EventName);
    }
}
