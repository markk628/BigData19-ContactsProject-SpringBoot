package com.markk628.contacts_project_v2.model.contact.contactfullinfo;

import com.markk628.contacts_project_v2.model.contact.projection.ContactFullInfoProjection;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ContactFullInfoDTO {
    @NotNull
    private int contactId;

    @NotNull
    @NotEmpty(message = "Name can't be empty")
    private String contactName;

    @Digits(integer = 11, fraction = 0, message = "Phone number must be digits")
    @Size(min = 11, max=11, message = "Phone number must be at least 11 digits long")
    private String phoneNumber;

    private String streetAddress;

    private String city;

    private String state;

    private String zipCode;

    private String country;

    @NotNull
    @NotEmpty(message = "Relationship can't be empty")
    private String relationship;

    @NotNull
    @NotEmpty(message = "Nationality can't be empty")
    private String nationality;

    private String profession;

    private String company;

    private String jobStreetAddress;

    private String jobCity;

    private String jobState;

    private String jobZipCode;

    private String jobCountry;

    public ContactFullInfoDTO(ContactFullInfoProjection contact) {
        this.contactId = contact.getContactId();
        this.contactName = contact.getContactName();
        this.phoneNumber = contact.getPhoneNumber();
        this.streetAddress = contact.getStreetAddress();
        this.city = contact.getCity();
        this.state = contact.getState();
        this.zipCode = contact.getZipCode();
        this.country = contact.getCountry();
        this.relationship = contact.getRelationship();
        this.nationality = contact.getNationality();
        this.profession = contact.getProfession();
        this.company = contact.getCompany();
        this.jobStreetAddress = contact.getJobStreetAddress();
        this.jobZipCode = contact.getJobZipCode();
        this.jobCity = contact.getJobCity();
        this.jobState = contact.getJobState();
        this.jobCountry = contact.getJobCountry();
    }

    public void updateValues(ContactFullInfoDTO contact) {
        this.contactName = contact.getContactName().equals(this.contactName) ? null : this.contactName;
        this.phoneNumber = contact.getPhoneNumber().equals(this.phoneNumber) ? null : this.phoneNumber;
        this.streetAddress = contact.getStreetAddress().equals(this.streetAddress) ? null : this.streetAddress;
        this.zipCode = contact.getZipCode().equals(this.zipCode) ? null : this.zipCode;
        this.city = contact.getCity().equals(this.city) ? null : this.city;
        this.state = contact.getState().equals(this.state) ? null : this.state;
        this.country = contact.getCountry().equals(this.country) ? null : this.country;
        this.relationship = contact.getRelationship().equals(this.relationship) ? null : this.relationship;
        this.profession = contact.getProfession().equals(this.profession) ? null : this.profession;
        this.company = contact.getCompany().equals(this.company) ? null : this.company;
        this.jobStreetAddress = contact.getJobStreetAddress().equals(this.jobStreetAddress) ? null : this.jobStreetAddress;
        this.jobZipCode = contact.getJobZipCode().equals(this.jobZipCode) ? null : this.jobZipCode;
        this.jobCity = contact.getJobCity().equals(this.jobCity) ? null : this.jobCity;
        this.jobState = contact.getJobState().equals(this.jobState) ? null : this.jobState;
        this.jobCountry = contact.getJobCountry().equals(this.jobCountry) ? null : this.jobCountry;
    }
}
