import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('Article')
export class Article {
    @PrimaryGeneratedColumn()
    id: number;

    @ApiProperty({
        description: "标题"
    })
    @Column()
    title: string;

    @ApiProperty({
        description: "内容"
    })
    @Column("varchar", { length: 15000 })
    content: string;

    @ApiProperty({
        description: "创建时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    date: Date;
    @ApiProperty({
        description: "更新时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    update_time: Date;

    @ApiProperty({
        description: "作者"
    })
    @Column()
    author: string;
    @ApiProperty({
        description: "作者ID"
    })
    @Column()
    authorID: string;

    @ApiProperty({
        description: "文章封面图片"
    })
    @Column()
    coverPhoto: string



    // 可以添加其他属性，如文章封面图片等

    //   constructor(title: string, content: string, date: Date, author: string) {
    //     this.title = title;
    //     this.content = content;
    //     this.date = date;
    //     this.author = author;
    //   }
}