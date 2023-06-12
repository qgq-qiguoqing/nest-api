import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { ClassificationService } from './classification.service';
import { CreateClassificationDto } from './dto/create-classification.dto';
import { UpdateClassificationDto } from './dto/update-classification.dto';
import { ApiTags, ApiOperation, ApiBody, ApiProperty, ApiOkResponse } from '@nestjs/swagger';
import { ApiException } from 'src/common/filter/http-exception/api.exception';
import { ApiErrorCode } from 'src/common/enums/api-error-code.enum';
interface PaginationQueryDto {
  pagerIndex: number,
  pagerSize: number,
  name: string
}
@ApiTags('classification')
@Controller('classification')
export class ClassificationController {
  constructor(private readonly classificationService: ClassificationService) { }

  @Post('create')
  async create(@Body() createClassificationDto: CreateClassificationDto) {
    const res = await this.classificationService.findOne(createClassificationDto.name)
    if (res) {
      throw new ApiException('分类名已存在', ApiErrorCode.USER_NOTEXIST);
    }
    return this.classificationService.create(createClassificationDto);
  }

  @Post('getClassification')
  async find(@Body() paginationQuery: PaginationQueryDto) {


    const { pagerIndex, pagerSize, name } = paginationQuery;
    const total = await this.classificationService.count(name)
    const data = await this.classificationService.find({
      name: name,
      skip: (pagerIndex - 1) * pagerSize,
      take: pagerSize,
    });
    return {
      list: data,
      pagerIndex: pagerIndex,
      total: total
    };

  }

  @Post('getClassificationOne')
  findOne(@Param('name') name: string) {
    return this.classificationService.findOne(name);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateClassificationDto: UpdateClassificationDto) {
    return this.classificationService.update(+id, updateClassificationDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.classificationService.remove(+id);
  }
}
