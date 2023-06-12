import { Injectable } from '@nestjs/common';
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, Like } from "typeorm";
import { CreateClassificationDto } from './dto/create-classification.dto';
import { UpdateClassificationDto } from './dto/update-classification.dto';
import { Classification } from './entities/classification.entity';


@Injectable()
export class ClassificationService {

  constructor(@InjectRepository(Classification) private classification: Repository<Classification>) { }

  create(createClassificationDto: CreateClassificationDto) {

    return this.classification.save({
      ...createClassificationDto,
      nameID: new Date().getTime().toString()
    })
  }

  findAll() {
    return `This action returns all classification`;
  }

  findOne(name: string) {
    return this.classification.findOne({
      where: {
        name
      }
    });
  }
  find(v: any) {
    return v.name ? this.classification.find({
      where: {
        name: Like(`%${v.name}%`),
      },
      skip: v.skip,
      take: v.take,
    }) : this.classification.find({

      skip: v.skip,
      take: v.take,
    })
  }
  count(v: string) {
    return v ? this.classification.count({
      where: {
        name: Like(`%${v}%`),
      },
    }) : this.classification.count()
  }
  update(id: number, updateClassificationDto: UpdateClassificationDto) {
    return `This action updates a #${id} classification`;
  }

  remove(id: number) {
    return `This action removes a #${id} classification`;
  }
}
