import { Injectable } from '@nestjs/common';
import { CreateBackgroundImageDto } from './dto/create-background-image.dto';
import { UpdateBackgroundImageDto } from './dto/update-background-image.dto';
import { BackgroundImage } from './entities/background-image.entity';
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
@Injectable()
export class BackgroundImageService {
  constructor(@InjectRepository(BackgroundImage) private background: Repository<BackgroundImage>) { }
  create(createBackgroundImageDto: CreateBackgroundImageDto) {
    return this.background.save(createBackgroundImageDto)
  }

  findAll() {
    return this.background.find()
  }

  findOne(id: number) {
    return `This action returns a #${id} backgroundImage`;
  }

  update(id: number, updateBackgroundImageDto: UpdateBackgroundImageDto) {
    return `This action updates a #${id} backgroundImage`;
  }

  remove(id: number) {
    return this.background.delete(id);
  }
}
