package com.example.cliente_backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.cliente_backend.model.Cliente;
import com.example.cliente_backend.repository.ClienteRepository;

@RestController
@RequestMapping("/api/clientes")
@CrossOrigin(origins = "*")
public class ClienteController {

  @Autowired
  private ClienteRepository clienteRepository;

  @GetMapping
  public List<Cliente> listar() {
    return clienteRepository.findAll();
  }

  @PostMapping
  public Cliente guardar(@RequestBody Cliente cliente) {
    return clienteRepository.save(cliente);
  }

  @DeleteMapping("/{id}")
  public void eliminar(@PathVariable Long id) {
    clienteRepository.deleteById(id);
  }
}
