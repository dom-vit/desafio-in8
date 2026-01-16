import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from './entities/order.entity';
import { CreateOrderDto } from './dto/create-order.dto';

@Injectable()
export class OrdersService {
  constructor(
    @InjectRepository(Order)
    private orderRepository: Repository<Order>,
  ) {}

  async create(createOrderDto: CreateOrderDto) {
    // Cria o objeto do pedido
    const novoPedido = this.orderRepository.create(createOrderDto);
    // Salva no Postgres
    return await this.orderRepository.save(novoPedido);
  }

  findAll() {
    return this.orderRepository.find();
  }
}
