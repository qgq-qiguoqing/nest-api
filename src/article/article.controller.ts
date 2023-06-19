import { Controller, Get, Post, Body, Patch, Param, Delete, HttpCode } from '@nestjs/common';
import { ArticleService } from './article.service';
import { CreateArticleDto, findPara } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';
import { ApiTags, ApiOperation, ApiBody, ApiProperty, ApiOkResponse } from '@nestjs/swagger';
import { Article } from './entities/article.entity';
import { timeFormat } from '../utils/useDateTime'

@ApiTags('Article')
@Controller('article')
export class ArticleController {
  constructor(private readonly articleService: ArticleService) { }
  @ApiOperation({ summary: '添加文章' })
  @ApiBody({ type: CreateArticleDto, description: '文章信息' })
  @ApiOkResponse({ description: 'Return all cats', })
  @Post('add')
  create(@Body() createArticleDto: CreateArticleDto) {
    return this.articleService.create(createArticleDto);
  }
  @Post('getList')
  @HttpCode(200)
  async find(@Body() para: findPara) {
    const { pagerIndex, pagerSize, title, nameID } = para;
    const total = await this.articleService.count(title, nameID)
    const data = await this.articleService.find({
      title: title,
      nameID: nameID,
      pagerIndex: (pagerIndex - 1) * pagerSize,
      pagerSize: pagerSize,
    });
    return {
      list: data.map(it => {
        it.createTime = timeFormat('yyyy-mm-dd hh:ii:ss', it.createTime) as any
        return it
      }),
      pagerIndex: pagerIndex,
      pagerSize,
      total: total
    };
    // return this.articleService.find(para)
  }
  @Get()
  findAll() {
    return this.articleService.findAll();
  }

  @Post('getDetails')
  @HttpCode(200)
  findOne(@Body() para: any) {
    return this.articleService.findOne(para.id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateArticleDto: UpdateArticleDto) {
    return this.articleService.update(+id, updateArticleDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.articleService.remove(+id);
  }
}
