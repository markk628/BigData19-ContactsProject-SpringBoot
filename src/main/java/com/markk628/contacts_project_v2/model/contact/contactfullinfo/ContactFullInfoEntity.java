package com.markk628.contacts_project_v2.model.contact.contactfullinfo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="full_info")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ContactFullInfoEntity {
    @Id
    @Column(name="contact_id")
    private Integer contactId;

    @Column(name="contact_name")
    private String contactName;

    @Column(name="phone_number")
    private String phoneNumber;

    @Column(name="address")
    private String address;

    @Column(name="address_id")
    private Integer addressId;

    @Column(name="street_address")
    private String streetAddress;

    @Column(name="city")
    private String city;

    @Column(name="state")
    private String state;

    @Column(name="zip_code")
    private String zipCode;

    @Column(name="country")
    private String country;

    @Column(name="relationship")
    private String relationship;

    @Column(name="nationality")
    private String nationality;

    @Column(name="job_id")
    private Integer jobId;

    @Column(name="profession")
    private String profession;

    @Column(name="company")
    private String company;

    @Column(name="job_address")
    private String jobAddress;

    @Column(name="work_address_id")
    private Integer workAddressId;

    @Column(name="job_street_address")
    private String jobStreetAddress;

    @Column(name="job_city")
    private String jobCity;

    @Column(name="job_state")
    private String jobState;

    @Column(name="job_zip_code")
    private String jobZipCode;

    @Column(name="job_country")
    private String jobCountry;
}
