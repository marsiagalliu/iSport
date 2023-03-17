package com.dojo.isport.models;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "events")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotEmpty(message = "Event name is required!")
    @Size(min = 3, max = 20, message = "Name must be between 3 and 20 characters")
    private String eventName;

    @NotEmpty(message = "Event location is required!")
    @Size(min = 3, max = 20, message = "Location name must be between 3 and 20 characters")
    private String eventLocation;


    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "attendees_events",
            joinColumns = @JoinColumn(name = "event_id"),
            inverseJoinColumns = @JoinColumn(name = "attendee_id")
    )
    private List<User> attendees;

    @NotNull(message = "Is required!")
    @Min(value = 1)
    private Integer maxAttendees;

    @NotNull(message = "Date is required!")
    @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
    private Date date;

    private String information;

    @OneToMany(mappedBy="event",fetch = FetchType.LAZY)
    @Column(updatable=false)
    private List<Message> messages;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator_id")
    private User creator;

    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;

    public Event() {
    }

    public Event(Long id, String eventName, String eventLocation, List<User> attendees, Integer maxAttendees, Date date, String information, List<Message> messages) {
        this.id = id;
        this.eventName = eventName;
        this.eventLocation = eventLocation;
        this.attendees = attendees;
        this.maxAttendees = maxAttendees;
        this.date = date;
        this.information = information;
        this.messages = messages;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public List<User> getAttendees() {
        return attendees;
    }

    public void setAttendees(List<User> users) {
        this.attendees = users;
    }

    public Integer getMaxAttendees() {
        return maxAttendees;
    }

    public void setMaxAttendees(Integer maxAttendees) {
        this.maxAttendees = maxAttendees;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getInformation() {
        return information;
    }

    public void setInformation(String information) {
        this.information = information;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}
