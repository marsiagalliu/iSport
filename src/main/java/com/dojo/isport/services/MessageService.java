package com.dojo.isport.services;

import com.dojo.isport.models.Message;
import com.dojo.isport.repositories.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MessageService {

    @Autowired
    MessageRepository messageRepository;

    public List<Message> allMessages() {
        return messageRepository.findAll();
    }
    public List<Message> findAllByMessageId(Long id) {
        return messageRepository.findAllByEventId(id);
    }


    public Message createMessage(Message message) {
        return messageRepository.save(message);
    }

    public Message findMessage(Long id) {
        Optional<Message> optionalMessage = messageRepository.findById(id);
        if(optionalMessage.isPresent()) {
            return optionalMessage.get();
        } else {
            return null;
        }
    }

    public Message updateMessage(Message message) {
        return messageRepository.save(message);
    }

    public void deleteMessage(Long id) {
        messageRepository.deleteById(id);
    }
}
