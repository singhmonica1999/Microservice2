package com.mooo.monicasingh.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name="media_info")
public class MediaEntity {
    @Id
    @Column(name="mediainfo_id",nullable = false)
    private Long mediainfo_id;

    @Column(name="user_id",nullable = false)
    private Long user_id;

    @Column(name="title")
    private String title;

    @Column(name="genre")
    private String genre;

    @Column(name="type")
    private String type;

    @Column(name="visibility")
    private String visibility;

    @Column(name="description")
    private String description;

    @Column(name="release_date")
    private LocalDate release_date;

    @Column(name="rating")
    private int rating;
}
