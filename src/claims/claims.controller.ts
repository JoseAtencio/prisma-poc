import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ClaimsService } from './claims.service';
import { CreateClaimDto } from './dto/create-claim.dto';
import { UpdateClaimDto } from './dto/update-claim.dto';
import { Claims, Prisma } from '@prisma/client';

@Controller('claims')
export class ClaimsController {
  constructor(private readonly claimsService: ClaimsService) {}

  @Post()
  create(@Body() createClaimDto: Prisma.ClaimsCreateInput) {
    return this.claimsService.create(createClaimDto);
  }

  @Get()
  findAll() {
    return this.claimsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: number) {
    return this.claimsService.findOne({id:+id});
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateClaimDto: UpdateClaimDto) {
    return this.claimsService.update({id: +id}, updateClaimDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.claimsService.remove({id:+id});
  }
}
