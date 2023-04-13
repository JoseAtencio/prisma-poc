import { Module } from '@nestjs/common';
import { ClaimsService } from './claims.service';
import { ClaimsController } from './claims.controller';
import {PrismaService} from '../prisma.service'

@Module({
  controllers: [ClaimsController],
  providers: [ClaimsService, PrismaService]
})
export class ClaimsModule {}
