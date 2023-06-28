import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { BackgroundImageService } from './background-image.service';
import { CreateBackgroundImageDto } from './dto/create-background-image.dto';
import { UpdateBackgroundImageDto } from './dto/update-background-image.dto';
type paraType = {
  id: number;
}
@Controller('background-image')
export class BackgroundImageController {
  constructor(private readonly backgroundImageService: BackgroundImageService) { }

  @Post('create')
  create(@Body() createBackgroundImageDto: CreateBackgroundImageDto) {
    return this.backgroundImageService.create(createBackgroundImageDto);
  }

  @Post('getList')
  findAll() {
    return this.backgroundImageService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.backgroundImageService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateBackgroundImageDto: UpdateBackgroundImageDto) {
    return this.backgroundImageService.update(+id, updateBackgroundImageDto);
  }

  @Post('delete')
  remove(@Param('id') para: paraType) {
    return this.backgroundImageService.remove(+para.id);
  }
}
