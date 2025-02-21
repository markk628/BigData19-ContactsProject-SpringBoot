package com.markk628.contacts_project_v2.repository;

import com.markk628.contacts_project_v2.model.contact.contactfullinfo.ContactFullInfoEntity;
import com.markk628.contacts_project_v2.model.contact.projection.ContactFullInfoProjection;
import com.markk628.contacts_project_v2.model.contact.projection.ContactProjection;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface ContactRepository extends CrudRepository<ContactFullInfoEntity, Integer> {
    String INSERT_CONTACT =
            "CALL insert_contact_if_not_in_table(:name,             " +
            "                                    :phoneNumber,      " +
            "                                    :streetAddress,    " +
            "                                    :zipCode,          " +
            "                                    :city,             " +
            "                                    :state,            " +
            "                                    :country,          " +
            "                                    :relationship,     " +
            "                                    :nationality,      " +
            "                                    :profession,       " +
            "                                    :company,          " +
            "                                    :jobStreetAddress, " +
            "                                    :jobZipCode,       " +
            "                                    :jobCity,          " +
            "                                    :jobState,         " +
            "                                    :jobCountry,       " +
            "                                    :appUserId)        ";

    String SELECT_CONTACTS =
            "CALL select_contacts(:appUserId)";

    String SELECT_CONTACTS_WITH_NAME =
            "CALL select_contacts_with_name(:appUserId, :contactName)";

    String SELECT_CONTACT =
            "CALL select_contact(:appUserId, :contactId)";

    String SELECT_CONTACT_TO_UPDATE =
            "CALL select_contact_to_update(:appUserId, :contactId)";

    String UPDATE_CONTACT =
            "CALL update_contact(:contactId,        " +
            "                    :name,             " +
            "                    :phoneNumber,      " +
            "                    :streetAddress,    " +
            "                    :zipCode,          " +
            "                    :city,             " +
            "                    :state,            " +
            "                    :country,          " +
            "                    :relationship,     " +
            "                    :profession,       " +
            "                    :company,          " +
            "                    :jobStreetAddress, " +
            "                    :jobZipCode,       " +
            "                    :jobCity,          " +
            "                    :jobState,         " +
            "                    :jobCountry)       ";

    String DELETE_PARENTS_WITH_NO_CHILD =
            "CALL delete_parents_with_no_child(:didUpdatePhoneNumber,            " +
            "                                  :didUpdateStreetAddressOrZipCode, " +
            "                                  :didUpdateCity,                   " +
            "                                  :didUpdateState,                  " +
            "                                  :didUpdateCountry,                " +
            "                                  :didUpdateRelationship,           " +
            "                                  :didUpdateProfession,             " +
            "                                  :didUpdateCompany)                ";

    String DELETE_CONTACT =
            "CALL delete_contact(:contactId)";

    @Modifying
    @Transactional
    @Query(value = INSERT_CONTACT, nativeQuery = true)
    Integer insertContact(@Param("name") String name,
                          @Param("phoneNumber") String phoneNumber,
                          @Param("streetAddress") String streetAddress,
                          @Param("zipCode") String zipCode,
                          @Param("city") String city,
                          @Param("state") String state,
                          @Param("country") String country,
                          @Param("relationship") String relationship,
                          @Param("nationality") String nationality,
                          @Param("profession") String profession,
                          @Param("company") String company,
                          @Param("jobStreetAddress") String jobStreetAddress,
                          @Param("jobZipCode") String jobZipCode,
                          @Param("jobCity") String jobCity,
                          @Param("jobState") String jobState,
                          @Param("jobCountry") String jobCountry,
                          @Param("appUserId") String appUserId);

    @Query(value = SELECT_CONTACTS, nativeQuery = true)
    List<ContactProjection> getContacts(@Param("appUserId") String appUserId);

    @Query(value = SELECT_CONTACTS_WITH_NAME, nativeQuery = true)
    List<ContactProjection> getContactsByName(@Param("appUserId") String appUserId,
                                            @Param("contactName") String contactName);

    @Query(value = SELECT_CONTACT, nativeQuery = true)
    ContactProjection getContact(@Param("appUserId") String appUserId,
                                 @Param("contactId") int contactId);

    @Query(value = SELECT_CONTACT_TO_UPDATE, nativeQuery = true)
    ContactFullInfoProjection getContactToUpdate(@Param("appUserId") String appUserId,
                                                 @Param("contactId") int contactId);

    @Modifying
    @Transactional
    @Query(value = UPDATE_CONTACT, nativeQuery = true)
    void updateContact(@Param("contactId") Integer contactId,
                       @Param("name") String name,
                       @Param("phoneNumber") String phoneNumber,
                       @Param("streetAddress") String streetAddress,
                       @Param("zipCode") String zipCode,
                       @Param("city") String city,
                       @Param("state") String state,
                       @Param("country") String country,
                       @Param("relationship") String relationship,
                       @Param("profession") String profession,
                       @Param("company") String company,
                       @Param("jobStreetAddress") String jobStreetAddress,
                       @Param("jobZipCode") String jobZipCode,
                       @Param("jobCity") String jobCity,
                       @Param("jobState") String jobState,
                       @Param("jobCountry") String jobCountry);

    @Modifying
    @Transactional
    @Query(value = DELETE_PARENTS_WITH_NO_CHILD, nativeQuery = true)
    void deleteParentsWithNoChild(@Param("didUpdatePhoneNumber") int didUpdatePhoneNumber,
                                  @Param("didUpdateStreetAddressOrZipCode") int didUpdateStreetAddressOrZipCode,
                                  @Param("didUpdateCity") int didUpdateCity,
                                  @Param("didUpdateState") int didUpdateState,
                                  @Param("didUpdateCountry") int didUpdateCountry,
                                  @Param("didUpdateRelationship") int didUpdateRelationship,
                                  @Param("didUpdateProfession") int didUpdateProfession,
                                  @Param("didUpdateCompany") int didUpdateCompany);

    @Modifying
    @Transactional
    @Query(value = DELETE_CONTACT, nativeQuery = true)
    void deleteContact(@Param("contactId") int contactId);
}
