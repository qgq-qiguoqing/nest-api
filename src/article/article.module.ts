import { Module } from '@nestjs/common';
import { ArticleService } from './article.service';
import { ArticleController } from './article.controller';
import { TypeOrmModule } from "@nestjs/typeorm";
import { User } from '../user/entities/user.entity'
import { Article } from './entities/article.entity';
@Module({
  controllers: [ArticleController],
  providers: [ArticleService],
  imports: [TypeOrmModule.forFeature([Article, User])],

})
export class ArticleModule { }
