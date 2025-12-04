package com.example.cliente_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.cliente_backend.model.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {

}
