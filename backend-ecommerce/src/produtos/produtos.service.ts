import { Injectable, NotFoundException } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import {
  ProdutoPadrao,
  FornecedorBR,
  FornecedorEU,
} from './entities/produto.entity';

@Injectable()
export class ProdutosService {
  constructor(private readonly httpService: HttpService) {}

  async findAll(): Promise<ProdutoPadrao[]> {
    const urlBR =
      'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider';
    const urlEU =
      'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider';

    const [resBR, resEU] = await Promise.all([
      firstValueFrom(this.httpService.get<FornecedorBR[]>(urlBR)),
      firstValueFrom(this.httpService.get<FornecedorEU[]>(urlEU)),
    ]);

    const brasil: ProdutoPadrao[] = resBR.data.map((item) => ({
      id: item.id,
      nome: item.nome,
      preco: Number(item.preco),
      descricao: item.descricao,
      imagem: item.imagem,
      provider: 'BR' as const,
    }));

    const europa: ProdutoPadrao[] = resEU.data.map((item) => ({
      id: item.id,
      nome: item.name,
      preco: Number(item.price),
      descricao: item.description,
      imagem: item.gallery?.[0] ?? '',
      provider: 'EU' as const,
    }));

    return [...brasil, ...europa];
  }

  async findAllFiltered(search?: string): Promise<ProdutoPadrao[]> {
    const produtos = await this.findAll();
    if (!search) return produtos;

    const searchLower = search.toLowerCase();
    return produtos.filter(
      (p) =>
        p.nome.toLowerCase().includes(searchLower) ||
        p.provider.toLowerCase().includes(searchLower),
    );
  }

  async findOne(id: string): Promise<any> {
    // Tenta no Brasileiro
    try {
      const respBR = await firstValueFrom(
        this.httpService.get(
          `http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider/${id}`,
        ),
      );
      if (respBR.data) {
        return { ...respBR.data, provider: 'BR' };
      }
    } catch (e) {
      //egue para o próximo
    }

    // Tenta no Europeu
    try {
      const respEU = await firstValueFrom(
        this.httpService.get(
          `http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider/${id}`,
        ),
      );
      if (respEU.data) {
        return { ...respEU.data, provider: 'EU' };
      }
    } catch (e) {
      // Se falhou aqui cai em erro no final
      throw new NotFoundException(
        `Produto com ID ${id} não encontrado em nenhum fornecedor.`,
      );
    }

    // Caso chegue aqui por algum motivo obscuro
    throw new NotFoundException(`Produto com ID ${id} não encontrado.`);
  }
}
