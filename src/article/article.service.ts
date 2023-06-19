import { Injectable, } from '@nestjs/common';
import { CreateArticleDto, findPara } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, Like, In } from "typeorm";
import { Article } from './entities/article.entity';
@Injectable()
export class ArticleService {
  constructor(@InjectRepository(Article) private articleRepository: Repository<Article>) { }

  create(createArticleDto: CreateArticleDto) {

    return this.articleRepository.save(createArticleDto)
  }
  find(para: findPara) {
    let where = {
      title: para.title.length ? Like(`%${para.title}%`) : null,
      nameID: para.nameID.length ? In(para.nameID) : null
    }
    return (para.title.length || para.nameID.length) ? this.articleRepository.find({
      where,
      skip: para.pagerIndex,
      take: para.pagerSize,
    }) : this.articleRepository.find({

      skip: para.pagerIndex,
      take: para.pagerSize,
    })
  }
  findAll() {
    return this.articleRepository.find();
  }

  findOne(id: number, authorEmail: string) {
    return this.articleRepository.findOne({
      where: {
        id,
        authorEmail
      }
    });
  }
  findTitle(title: string) {
    return this.articleRepository.find({
      where: {
        title
      }
    })
  }
  count(title?: string, nameID?: string[]) {
    return this.articleRepository.count({
      where: {
        title,
        nameID: In(nameID)
      }
    })
  }
  update(id: number, updateArticleDto: UpdateArticleDto) {

    return this.articleRepository.update(id, updateArticleDto);
  }

  remove(id: number) {
    return this.articleRepository.delete(id);
  }
  findIndx() {
    return this.articleRepository.find({
      take: 10,
      order: {
        createTime: 'DESC'
      }
    })
  }
}
