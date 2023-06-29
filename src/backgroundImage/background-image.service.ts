import { Injectable } from '@nestjs/common';
import { CreateBackgroundImageDto } from './dto/create-background-image.dto';
import { UpdateBackgroundImageDto } from './dto/update-background-image.dto';
import { BackgroundImage } from './entities/background-image.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class BackgroundImageService {
  constructor(
    @InjectRepository(BackgroundImage)
    private background: Repository<BackgroundImage>,
  ) { }
  create(createBackgroundImageDto: CreateBackgroundImageDto) {
    let para = {
      url: createBackgroundImageDto.url,
      userEmail: createBackgroundImageDto.email,
    };
    return this.background.save(para);
  }

  findAll(email: string) {
    return this.background.find({
      where: {
        userEmail: email,
      },
    });
  }

  findOne(email) {
    return this.background.findOne({
      where: {
        isEnable: true,
        userEmail: email,
      },
    });
  }

  async update(id: number, email: string) {
    let isEnable = false;
    let ids = (
      await this.background.find({
        where: {
          userEmail: email,
        },
      })
    )
      .filter((it) => {
        if (it.id != id) {
          return it;
        } else {
          isEnable = it.isEnable;
        }
      })
      .map((it) => it.id);
    if (ids.length) {
      this.background.update(ids, {
        isEnable: false,
      });
    }

    return this.background.update(id, {
      isEnable: !isEnable,
    });
  }

  async remove(id: number) {
    let bg: any = await this.background.findOne({
      where: {
        id,
      },
    });

    let url = bg.url.split('/');
    fs.unlink(path.join('./uploads', url[url.length - 1]), (err) => {
      console.log(err);
    });
    return this.background.delete(id);
  }
}
