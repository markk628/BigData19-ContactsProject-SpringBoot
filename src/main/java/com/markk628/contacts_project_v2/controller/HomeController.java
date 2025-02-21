package com.markk628.contacts_project_v2.controller;

import com.markk628.contacts_project_v2.model.contact.contactfullinfo.ContactFullInfoDTO;
import com.markk628.contacts_project_v2.model.contact.projection.ContactFullInfoProjection;
import com.markk628.contacts_project_v2.model.contact.projection.ContactProjection;
import com.markk628.contacts_project_v2.repository.AuthenticationRepository;
import com.markk628.contacts_project_v2.repository.ContactRepository;
import com.markk628.contacts_project_v2.service.AuthenticationService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
public class HomeController {
    @Autowired
    private ContactRepository contactRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Autowired
    private AuthenticationService authenticationService;

    private ContactFullInfoDTO currentlyEditingContact;

    @GetMapping("/contacts/add")
    public String insertContactPage(Model model) {
        ContactFullInfoDTO contactFullInfoDTO = new ContactFullInfoDTO();
        model.addAttribute(contactFullInfoDTO);
        return "insert";
    }

    @PostMapping("/contacts/add")
    public String insertContact(RedirectAttributes attributes,
                                @Valid @ModelAttribute ContactFullInfoDTO contactFullInfoDTO,
                                BindingResult result) {
        if (result.hasErrors()) {
            return "insert";
        }
        String msg;
        Integer existingId = this.contactRepository.insertContact(contactFullInfoDTO.getContactName(),
                                                                  contactFullInfoDTO.getPhoneNumber(),
                                                                  contactFullInfoDTO.getStreetAddress(),
                                                                  contactFullInfoDTO.getZipCode(),
                                                                  contactFullInfoDTO.getCity(),
                                                                  contactFullInfoDTO.getState(),
                                                                  contactFullInfoDTO.getCountry(),
                                                                  contactFullInfoDTO.getRelationship(),
                                                                  contactFullInfoDTO.getNationality(),
                                                                  contactFullInfoDTO.getProfession(),
                                                                  contactFullInfoDTO.getCompany(),
                                                                  contactFullInfoDTO.getStreetAddress(),
                                                                  contactFullInfoDTO.getJobZipCode(),
                                                                  contactFullInfoDTO.getJobCity(),
                                                                  contactFullInfoDTO.getJobState(),
                                                                  contactFullInfoDTO.getJobCountry(),
                                                                  this.authenticationService.getCurrentUsername());
        if (existingId != null) {
            msg = contactFullInfoDTO.getContactName() + " successfully added";
        } else {
            msg = contactFullInfoDTO.getContactName() + " with phone number " + contactFullInfoDTO.getPhoneNumber() + " already exists";
        }
        attributes.addFlashAttribute("msg", msg);
        return "redirect:/contacts";
    }

    @GetMapping("/contacts")
    public String contactsPage(Model model) {
        model.addAttribute("contacts", this.contactRepository.getContacts(this.authenticationService.getCurrentUsername()));
        return "contacts";
    }

    @GetMapping("/contacts/{name}/search")
    public String contactsWithNamePage(Model model,
                                       @PathVariable String name) {
        model.addAttribute("contacts", this.contactRepository.getContactsByName(this.authenticationService.getCurrentUsername(), name));
        return "contacts";
    }

    @PostMapping("/contacts/search")
    public String searchContacts(@RequestParam("contact-to-search") String name) {
        return "redirect:/contacts/" + name + "/search";
    }

    @GetMapping("/contacts/{id}/edit")
    public String updateContactPage(Model model,
                                RedirectAttributes attributes,
                                @PathVariable int id) {
        ContactFullInfoProjection contact = this.contactRepository.getContactToUpdate(this.authenticationService.getCurrentUsername(), id);
        if (contact == null) {
            attributes.addFlashAttribute("msg", "Not your contact");
            return "redirect:/contacts";
        }
        this.currentlyEditingContact = new ContactFullInfoDTO(contact);
        model.addAttribute("contactFullInfoDTO", this.currentlyEditingContact);
        return "update";
    }

    @PostMapping("/contacts/{id}/edit")
    public String updateContact(RedirectAttributes attributes,
                                @Valid @ModelAttribute ContactFullInfoDTO contactFullInfoDTO,
                                BindingResult result,
                                @PathVariable int id) {
        if (result.hasErrors()) {
            return "update";
        }
        boolean didUpdateStreetAddressOrZipCode;
        boolean didUpdateCity;
        boolean didUpdateState;
        boolean didUpdateCountry;

        this.contactRepository.updateContact(id,
                                             contactFullInfoDTO.getContactName(),
                                             contactFullInfoDTO.getPhoneNumber(),
                                             contactFullInfoDTO.getStreetAddress(),
                                             contactFullInfoDTO.getZipCode(),
                                             contactFullInfoDTO.getCity(),
                                             contactFullInfoDTO.getState(),
                                             contactFullInfoDTO.getCountry(),
                                             contactFullInfoDTO.getRelationship(),
                                             contactFullInfoDTO.getProfession(),
                                             contactFullInfoDTO.getCompany(),
                                             contactFullInfoDTO.getJobStreetAddress(),
                                             contactFullInfoDTO.getJobZipCode(),
                                             contactFullInfoDTO.getJobCity(),
                                             contactFullInfoDTO.getJobState(),
                                             contactFullInfoDTO.getJobCountry());
        contactFullInfoDTO.updateValues(this.currentlyEditingContact);
        didUpdateStreetAddressOrZipCode = (contactFullInfoDTO.getStreetAddress() != null || contactFullInfoDTO.getZipCode() != null || contactFullInfoDTO.getJobStreetAddress() != null || contactFullInfoDTO.getJobZipCode() != null);
        didUpdateCity = (contactFullInfoDTO.getCity() != null || contactFullInfoDTO.getJobCity() != null);
        didUpdateState = (contactFullInfoDTO.getState() != null || contactFullInfoDTO.getJobState() != null);
        didUpdateCountry = (contactFullInfoDTO.getCountry() != null || contactFullInfoDTO.getJobCountry() != null);
        this.contactRepository.deleteParentsWithNoChild(contactFullInfoDTO.getPhoneNumber() == null ? 0 : 1,
                                                        !didUpdateStreetAddressOrZipCode ? 0 : 1,
                                                        !didUpdateCity ? 0 : 1,
                                                        !didUpdateState ? 0 : 1,
                                                        !didUpdateCountry ? 0 : 1,
                                                        contactFullInfoDTO.getRelationship() == null ? 0 : 1,
                                                        contactFullInfoDTO.getProfession() == null ? 0 : 1,
                                                        contactFullInfoDTO.getCompany() == null ? 0 : 1);
        attributes.addFlashAttribute("msg", this.currentlyEditingContact.getContactName() + " updated successfully");
        this.currentlyEditingContact = null;
        return "redirect:/contacts";
    }

    @PostMapping("/contacts/{id}/delete")
    public String deleteContact(RedirectAttributes attributes, @PathVariable int id) {
        ContactProjection contact = this.contactRepository.getContact(this.authenticationService.getCurrentUsername(), id);
        if (contact == null) {
            attributes.addFlashAttribute("msg", "Not your contact");
            return "redirect:/contacts";
        }
        this.contactRepository.deleteContact(id);
        attributes.addFlashAttribute("msg", contact.getContactName() + " deleted");
        return "redirect:/contacts";
    }
}
