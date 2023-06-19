import { Controller, Get, Post, Body, Patch, Param, Delete, HttpCode } from '@nestjs/common';
import { ClassificationService } from './classification.service';
import { CreateClassificationDto } from './dto/create-classification.dto';
import { UpdateClassificationDto } from './dto/update-classification.dto';
import { ApiTags, ApiOperation, ApiBody, ApiProperty, ApiOkResponse } from '@nestjs/swagger';
import { ApiException } from 'src/common/filter/http-exception/api.exception';
import { ApiErrorCode } from 'src/common/enums/api-error-code.enum';
import { timeFormat } from '../utils/useDateTime'
import { Classification } from './entities/classification.entity';

interface PaginationQueryDto {
  pagerIndex: number,
  pagerSize: number,
  name: string
}

class createClassification {
  @ApiProperty({ description: '分类名称' })
  name: string
}
class deleteDto {
  @ApiProperty({ description: '分类ID' })
  nameID: string
}
@ApiTags('classification')
@Controller('classification')
export class ClassificationController {
  constructor(private readonly classificationService: ClassificationService) { }
  @ApiOperation({ summary: '新建分类' })
  @ApiBody({ type: createClassification, description: '分类信息' })
  @ApiOkResponse({ description: 'Return all cats', type: Classification })
  @Post('create')
  async create(@Body() createClassificationDto: CreateClassificationDto) {
    const res = await this.classificationService.findOne(createClassificationDto.name)
    if (res) {
      throw new ApiException('分类名已存在', ApiErrorCode.STATUS1);
    }
    return this.classificationService.create(createClassificationDto);
  }

  @ApiOperation({ summary: '查询分类' })
  @ApiBody({ type: createClassification, description: '分类信息' })
  @ApiOkResponse({ description: 'Return all cats', type: [Classification] })
  @Post('getList')
  @HttpCode(200)
  async find(@Body() paginationQuery: PaginationQueryDto) {
    const { pagerIndex, pagerSize, name } = paginationQuery;
    const total = await this.classificationService.count(name)
    const data = await this.classificationService.find({
      name: name,
      skip: (pagerIndex - 1) * pagerSize,
      take: pagerSize,
    });
    return {
      list: data.map(it => {
        it.createTime = timeFormat('yyyy-mm-dd hh:ii:ss', it.createTime) as any
        return it
      }),
      pagerIndex: pagerIndex,
      total: total
    };

  }
  @ApiOperation({ summary: '获取所有分类' })
  @ApiOkResponse({ description: 'Return all cats', type: [Classification] })
  @Post('getListAll')
  @HttpCode(200)
  async findAll(@Body() v: any) {
    let list = await this.classificationService.findAll()
    return {
      list: list.map(it => {
        return {
          nameID: it.nameID,
          name: it.name
        }
      })
    }
  }


  @Post('getClassificationOne')
  @HttpCode(200)
  findOne(@Param('name') name: string) {
    return this.classificationService.findOne(name);
  }

  @ApiOperation({ summary: '更新分类' })
  @ApiBody({ type: createClassification, description: '分类信息' })
  @Post('update')
  async update(@Body() updateClassificationDto: UpdateClassificationDto) {
    const res = await this.classificationService.find(updateClassificationDto)

    if (res.length > 1) {
      throw new ApiException('分类名已存在', ApiErrorCode.STATUS1);
    }
    return this.classificationService.update(updateClassificationDto);
  }
  @ApiOperation({ summary: '删除分类' })
  @ApiBody({ type: deleteDto, description: '分类ID' })
  @Post('delete')
  remove(@Body() deleteDto: deleteDto) {
    return this.classificationService.remove(deleteDto.nameID);
  }
}
