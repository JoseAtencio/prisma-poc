import { Injectable } from '@nestjs/common';
import { CreateClaimDto } from './dto/create-claim.dto';
import { UpdateClaimDto } from './dto/update-claim.dto';
import { PrismaService } from '../prisma.service';

import { Claims, Prisma } from '@prisma/client';

@Injectable()
export class ClaimsService {
  constructor(private prisma: PrismaService) {}

  create(CreateClaimDto: Prisma.ClaimsCreateInput) {
    return this.prisma.claims.create({
      data: CreateClaimDto
    });
  }

  findAll() {
    return this.prisma.claims.findMany();
  }

  findOne(id: Prisma.ClaimsWhereUniqueInput) {
    return this.prisma.claims.findUnique({where:id});
  }

  update(where: Prisma.ClaimsWhereUniqueInput, data: Prisma.ClaimsUpdateInput) {
    return this.prisma.claims.update({
      data,
      where
    })
  }

  remove(id: Prisma.ClaimsWhereUniqueInput) {
    return this.prisma.claims.delete({
      where: id,
    })
  }
}
