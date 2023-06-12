import { Module } from '@nestjs/common';
import { ClassificationService } from './classification.service';
import { ClassificationController } from './classification.controller';
import { Classification } from './entities/classification.entity';
import { TypeOrmModule } from "@nestjs/typeorm";

@Module({
  controllers: [ClassificationController],
  providers: [ClassificationService],
  imports: [TypeOrmModule.forFeature([Classification])]
})
export class ClassificationModule { }
