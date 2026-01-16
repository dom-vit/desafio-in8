import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
} from 'typeorm';

@Entity('orders')
export class Order {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  clienteNome: string;

  @Column()
  clienteEmail: string;

  @Column('jsonb') // Salva a lista de produtos como JSON
  produtos: any[];

  @Column('decimal', { precision: 10, scale: 2 })
  total: number;

  @CreateDateColumn()
  dataPedido: Date;
}
