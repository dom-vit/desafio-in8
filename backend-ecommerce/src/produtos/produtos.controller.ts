import { Controller, Get, Param, Query } from '@nestjs/common';
import { ProdutosService } from './produtos.service';
import { ProdutoPadrao } from './entities/produto.entity';

@Controller('products')
export class ProdutosController {
  constructor(private readonly produtosService: ProdutosService) {}

  @Get()
  async findAll(@Query('search') search?: string): Promise<ProdutoPadrao[]> {
    return this.produtosService.findAllFiltered(search);
  }

  //busca por ID (Ex: /products/1)
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.produtosService.findOne(id);
  }
}
