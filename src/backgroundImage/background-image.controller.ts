import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { BackgroundImageService } from './background-image.service';
import { CreateBackgroundImageDto } from './dto/create-background-image.dto';
import { UpdateBackgroundImageDto } from './dto/update-background-image.dto';
import { HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBody, ApiProperty, ApiOkResponse } from '@nestjs/swagger';
import { Public } from 'src/public/public.decorator';

type paraType = {
  id?: number;
  email: string
}
@Controller('backgroundImage')
@ApiTags('backgroundImage')
export class BackgroundImageController {
  constructor(private readonly backgroundImageService: BackgroundImageService) { }
  @ApiOperation({ summary: "保存背景图" })
  @Post('create')
  create(@Body() createBackgroundImageDto: CreateBackgroundImageDto) {
    return this.backgroundImageService.create(createBackgroundImageDto);
  }

  @ApiOperation({ summary: "获取所有背景图" })
  @Post('getList')
  @HttpCode(200)
  async findAll(@Body() para: paraType) {
    return {
      list: await this.backgroundImageService.findAll(para.email)
    };
  }

  @ApiOperation({ summary: "获取背景图" })
  @Post('get')
  @HttpCode(200)
  @Public()
  findOne(@Body() para: paraType) {
    return this.backgroundImageService.findOne(para.email);
  }

  @ApiOperation({ summary: "设置背景图状态" })
  @Post('setStatus')
  @HttpCode(200)
  update(@Body() para: paraType,) {
    return this.backgroundImageService.update(+para.id, para.email);
  }

  @ApiOperation({ summary: "删除背景图" })
  @Post('delete')
  remove(@Body() para: paraType) {
    return this.backgroundImageService.remove(+para.id);
  }
}
