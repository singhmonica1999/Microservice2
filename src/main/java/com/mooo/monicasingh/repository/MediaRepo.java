package com.mooo.monicasingh.repository;

import com.mooo.monicasingh.entity.MediaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MediaRepo extends JpaRepository<MediaEntity,Long> {

}
