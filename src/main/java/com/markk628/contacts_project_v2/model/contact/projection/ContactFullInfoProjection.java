package com.markk628.contacts_project_v2.model.contact.projection;

public interface ContactFullInfoProjection {
    int getContactId();
    String getContactName();
    String getPhoneNumber();
    String getStreetAddress();
    String getCity();
    String getState();
    String getZipCode();
    String getCountry();
    String getRelationship();
    String getNationality();
    String getProfession();
    String getCompany();
    String getJobStreetAddress();
    String getJobCity();
    String getJobState();
    String getJobZipCode();
    String getJobCountry();
}

