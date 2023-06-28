import { Module } from '@nestjs/common';
import { BackgroundImageService } from './background-image.service';
import { BackgroundImageController } from './background-image.controller';
import { TypeOrmModule } from "@nestjs/typeorm";
import { BackgroundImage } from './entities/background-image.entity';
@Module({
  controllers: [BackgroundImageController],
  providers: [BackgroundImageService],
  imports: [TypeOrmModule.forFeature([BackgroundImage])]
})
export class BackgroundImageModule { }
