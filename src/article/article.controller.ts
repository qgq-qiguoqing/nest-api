import { Controller, Get, Post, Body, Patch, Param, Delete, HttpCode } from '@nestjs/common';
import { ArticleService } from './article.service';
import { CreateArticleDto, findPara } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';
import { ApiTags, ApiOperation, ApiBody, ApiProperty, ApiOkResponse } from '@nestjs/swagger';
import { Article } from './entities/article.entity';
import { timeFormat } from '../utils/useDateTime'
import { ApiException } from 'src/common/filter/http-exception/api.exception';
import { ApiErrorCode } from 'src/common/enums/api-error-code.enum';
import { Public } from 'src/public/public.decorator';
import he from 'he'
class updateType extends CreateArticleDto {
  id: number | string
  email: string
}
@ApiTags('Article')
@Controller('article')
export class ArticleController {
  constructor(private readonly articleService: ArticleService) { }
  @ApiOperation({ summary: '添加文章' })
  @ApiBody({ type: CreateArticleDto, description: '文章信息' })
  @ApiOkResponse({ description: 'Return all cats', })
  @Post('add')
  async create(@Body() createArticleDto: CreateArticleDto) {
    let res = await this.articleService.findTitle(createArticleDto.title)

    if (res) {
      throw new ApiException('文章标题已存在', ApiErrorCode.STATUS1);
    }

    return this.articleService.create(createArticleDto);
  }

  @Public()
  @Post('getList')
  @HttpCode(200)
  async find(@Body() para: findPara) {
    const { pagerIndex, pagerSize, title, nameID } = para;
    const total = await this.articleService.count(title, nameID || [])
    const data = await this.articleService.find({
      title: title,
      nameID: nameID || [],
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

  @Public()
  @Get('getIndex')
  findIndex() {
    return this.articleService.findIndx();
  }

  @Public()
  @Get('getHot')
  async getHot() {
    let list = await this.articleService.getHot()
    return list.map(it => {
      return {
        id: it.id,
        title: it.title
      }
    })
  }

  @Post('getDetails')
  @HttpCode(200)
  findOne(@Body() para: any) {
    return this.articleService.findOne(para.id, para.email);
  }

  @Public()
  @Post('getContent')
  @HttpCode(200)
  getContent(@Body() para: any) {

    return this.articleService.getContent(+para.id)
  }

  @Post('update')
  @HttpCode(200)
  update(@Body() updateArticleDto: updateType) {
    let id = updateArticleDto.id
    delete updateArticleDto.id
    delete updateArticleDto.email

    // updateArticleDto.content = he.encode(updateArticleDto.content.toString(), { strict: true })
    return this.articleService.update(+id, updateArticleDto);
  }

  @Post('delete')
  remove(@Body() para: any) {
    return this.articleService.remove(+para.id);
  }

}
