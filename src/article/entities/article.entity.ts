import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { Classification } from '../../classification/entities/classification.entity';
@Entity('article')
export class Article {
    @PrimaryGeneratedColumn()
    id: number;

    @ApiProperty({
        description: "标题"
    })
    @Column({ length: 1000 })
    title: string;

    @ApiProperty({
        description: "文章摘要"
    })
    @Column({ length: 1000 })
    abstract: string

    @ApiProperty({
        description: "文章内容"
    })
    @Column('json')
    content: string;

    @ApiProperty({
        description: "创建时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    createTime: Date;
    @ApiProperty({
        description: "更新时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    updateTime: Date;

    @ApiProperty({
        description: "作者"
    })
    @Column()
    author: string;

    @ApiProperty({
        description: "作者邮箱"
    })
    @Column()
    authorEmail: string;

    @ApiProperty({
        description: "是否为热门文章"
    })
    @Column({ default: false })
    isHot: boolean
    // @ApiProperty({
    //     description: "文章封面图片"
    // })
    // @Column()
    // coverPhoto: string

    @ApiProperty({
        description: "分类ID"
    })
    @Column()
    nameID: string

    // @ManyToOne(() => Classification, classification => classification.articles)
    // @JoinColumn({ name: 'id' })
    // classification: Classification;

    @ApiProperty({
        description: "分类"
    })
    @Column()
    name: string



    // 可以添加其他属性，如文章封面图片等

    //   constructor(title: string, content: string, date: Date, author: string) {
    //     this.title = title;
    //     this.content = content;
    //     this.date = date;
    //     this.author = author;
    //   }
}