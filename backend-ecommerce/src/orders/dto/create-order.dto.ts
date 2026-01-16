import {
  IsString,
  IsEmail,
  IsArray,
  IsNumber,
  ValidateNested,
  IsNotEmpty,
} from 'class-validator';
import { Type } from 'class-transformer';

// DTO auxiliar para os itens do carrinho
export class ProdutoPedidoDto {
  @IsString()
  @IsNotEmpty()
  nome: string;

  @IsNumber()
  quantidade: number;

  @IsNumber()
  preco: number;
}

// DTO principal do Pedido
export class CreateOrderDto {
  @IsString()
  @IsNotEmpty({ message: 'O nome do cliente é obrigatório' })
  clienteNome: string;

  @IsEmail({}, { message: 'E-mail inválido' })
  clienteEmail: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ProdutoPedidoDto)
  produtos: ProdutoPedidoDto[];

  @IsNumber()
  total: number;
}
