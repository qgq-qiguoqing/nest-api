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
    return this.classification.find()
  }

  findOne(name: string) {
    return this.classification.findOne({
      where: {
        name
      }
    });
  }
  find(v: any) {
    if (v.take) {
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
    } else {
      return this.classification.find({
        where: {
          name: v.name,
        },
      })
    }
  }
  count(v: string) {
    return v ? this.classification.count({
      where: {
        name: Like(`%${v}%`),
      },
    }) : this.classification.count()
  }
  async update(updateClassificationDto: UpdateClassificationDto) {
    return await this.classification.update({ nameID: updateClassificationDto.nameID }, {
      name: updateClassificationDto.name
    })
  }

  remove(id: string) {
    return this.classification.delete({ nameID: id })
  }
}
