package com.dojo.isport.controllers;

import com.dojo.isport.models.Event;
import com.dojo.isport.models.LoginUser;
import com.dojo.isport.models.Message;
import com.dojo.isport.models.User;
import com.dojo.isport.services.EventService;
import com.dojo.isport.services.MessageService;
import com.dojo.isport.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    EventService eventService;

    @Autowired
    MessageService messageService;

    @Autowired
    UserService userService;

    @GetMapping("/")
    public String index(Model model, @ModelAttribute("newUser") User newUser,
                        @ModelAttribute("newLogin") User newLogin) {

        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
    }

    @GetMapping("/register")
    public String register(Model model, @ModelAttribute("newUser") User newUser,
                        @ModelAttribute("newLogin") User newLogin) {

        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "register.jsp";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
                           HttpSession session) {
        userService.register(newUser, result);

        if (result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }

        session.setAttribute("loggedInUserID", newUser.getId());
        return "redirect:/dashboard";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
                        HttpSession session) {
        User user = userService.login(newLogin, result);

        System.out.println(user);

        if (result.hasErrors()) {
            result.getAllErrors().forEach(objectError -> System.out.println(objectError.toString()));
            model.addAttribute("newUser", new User());
            return "index.jsp";
        }
        session.setAttribute("loggedInUserID", user.getId());
        return "redirect:/dashboard";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }


    @RequestMapping("/dashboard")
    public String dashboard(HttpSession session, Model model, @ModelAttribute("event") Event event) {
        List<Event> events = eventService.allEvents();
        Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");

        if (loggedInUserID == null) {

            return "redirect:/";
        }

        User loggedInUser = userService.findOneUser(loggedInUserID);
        Date currentDate = new Date();
        model.addAttribute("user", loggedInUser);
        model.addAttribute("event", events);
        model.addAttribute("currentDate", currentDate);
        model.addAttribute("oneEvent", event);
        return "dashboard.jsp";

    }

    @RequestMapping("/event/{id}")
    public String show(Model model, @PathVariable("id") Long id, HttpSession session){
        Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");

        if (loggedInUserID == null) {

            return "redirect:/";
        }
        User loggedInUser = userService.findOneUser(loggedInUserID);
        model.addAttribute("user", loggedInUser);
        Event event = eventService.findEvent(id);
        List<Message> messages = messageService.findAllByMessageId(id);
        model.addAttribute("sportEvent", event);
        model.addAttribute("message", messages);
        model.addAttribute("newMessage", new Message());
        return "show.jsp";
    }

    @RequestMapping("/event/new")
    public String addEvent(@ModelAttribute("event") Event event) {
        return "new.jsp";
    }

    @PostMapping("/event/new")
    public String addEvent(@Valid @ModelAttribute("event") Event event, BindingResult result,
                             HttpSession session) {
        if (result.hasErrors()) {
            result.getAllErrors().forEach(objectError -> System.out.println(objectError.toString()));
            return "new.jsp";
        } else {
            Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");

            if (loggedInUserID == null) {

                return "redirect:/dashboard";
            }

            User loggedInUser = userService.findOneUser(loggedInUserID);
            event.setCreator(loggedInUser);
            eventService.createEvent(event);
            return "redirect:/dashboard";
        }
    }

    @PostMapping("/event/{id}")
    public String addMessage(@PathVariable("id") Long id,@Valid @ModelAttribute("newMessage") Message message, BindingResult result,
                          HttpSession session) {
        if (result.hasErrors()) {
            result.getAllErrors().forEach(objectError -> System.out.println(objectError.toString()));
            return "edit.jsp";
        } else {
            Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");
            if (loggedInUserID == null) {
                return "redirect:/dashboard";
            }
            User loggedInUser = userService.findOneUser(loggedInUserID);
            message.setUser(loggedInUser);
            message.setEvent(eventService.findEvent(id));
            message.setId(null);
            messageService.createMessage(message);
            return "redirect:/event/" + id;
        }
    }

    @GetMapping("/event/{id}/edit")
    public String editEvent(@PathVariable("id") Long id, Model model){
        Event event = eventService.findEvent(id);
        model.addAttribute("event", event);

        return "edit.jsp";
    }

    @GetMapping("/users/{id}/edit")
    public String editUser(@PathVariable("id") Long id, Model model, HttpSession session){
        Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");
        if (loggedInUserID == null) {

            return "redirect:/";
        }
        User loggedInUser = userService.findOneUser(loggedInUserID);
        model.addAttribute("user", loggedInUser);
        userService.findOneUser(id);
        return "edit-user.jsp";
    }

    @PutMapping("/event/{id}/edit")
    public String updateEvent(@Valid @ModelAttribute("event") Event event, BindingResult result,
                                HttpSession session){
        if (result.hasErrors()) {
            result.getAllErrors().forEach(objectError -> System.out.println(objectError.toString()));
            return "edit.jsp";
        }
        else {
            Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");

            if (loggedInUserID == null) {

                return "redirect:/";
            }
            User loggedInUser = userService.findOneUser(loggedInUserID);
            event.setCreator(loggedInUser);

            Event dbEvent = eventService.findEvent(event.getId());
            dbEvent.setEventName(event.getEventName());
            dbEvent.setEventLocation(event.getEventLocation());
            dbEvent.setDate(event.getDate());
            dbEvent.setInformation(event.getInformation());

            eventService.updateEvent(dbEvent);
            return "redirect:/event/" + event.getId();
        }
    }

    @PutMapping("/users/{id}/edit")
    public String updateUser(@Valid @ModelAttribute("user") User user, BindingResult result,
                              HttpSession session){
        if (result.hasErrors()) {
            result.getAllErrors().forEach(objectError -> System.out.println(objectError.toString()));
            return "edit-user.jsp";
        }
        else {
            Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");

            if (loggedInUserID == null) {

                return "redirect:/";
            }

            User dbUser = userService.findOneUser(user.getId());
            dbUser.setFirstName(user.getFirstName());
            dbUser.setLastName(user.getLastName());
            dbUser.setEmail(user.getEmail());
            dbUser.setPassword(user.getPassword());
            userService.update(dbUser);
            return "redirect:/users/" + user.getId();
        }
    }

    @RequestMapping("/event/{id}/delete")
    public String deleteEvent(@PathVariable("id") Long id){
        for(Message m : messageService.findAllByMessageId(id)) {
            messageService.deleteMessage(m.getId());
        }
        eventService.deleteEvent(id);
        return "redirect:/dashboard";
    }

    @RequestMapping("/search")
    public String search(Model model){
        return "search.jsp";
    }

    @RequestMapping("/search/{EventName}")
    public String search(@PathVariable("EventName") String EventName,Model model, HttpSession session){
        List<Event> events = eventService.findByName(EventName);
        model.addAttribute("search",events );
        Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");
        if (loggedInUserID == null) {
            return "redirect:/dashboard";
        }
        User loggedInUser = userService.findOneUser(loggedInUserID);
        model.addAttribute("user", loggedInUser);
        return "search.jsp";
    }

    @PostMapping("/search")
    public String searchEvent(@RequestParam(value = "name") String name,Model model) {
        model.addAttribute("search" , eventService.findByName(name));
        return "redirect:/search/" + name;
    }

    @PostMapping("/joinEvent/{eventId}")
    public String join(@PathVariable("eventId") Long eventId, HttpSession session, Model model){
        Event event = eventService.findEvent(eventId);
        List<User> attendees = event.getAttendees();
        Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");
        User loggedInUser = userService.findOneUser(loggedInUserID);
        attendees.add(loggedInUser);
        event.setAttendees(attendees);
        eventService.createEvent(event);
        return "redirect:/dashboard";
    }

    @RequestMapping("/users/{id}")
    public String account(Model model, @PathVariable("id") Long id, HttpSession session){
        Long loggedInUserID = (Long) session.getAttribute("loggedInUserID");
        if (loggedInUserID == null) {

            return "redirect:/";
        }
        User loggedInUser = userService.findOneUser(loggedInUserID);
        model.addAttribute("user", loggedInUser);
        Event event = eventService.findEvent(id);
        List<Message> messages = messageService.findAllByMessageId(id);
        model.addAttribute("sportEvent", event);

        return "account.jsp";
    }
}
