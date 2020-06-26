<template>
  <div class="dashboard-container">
    <div class="app-container">
      <el-card class="box-card">
        <el-form ref="addFormRef" :model="addForm" label-width="120px">
          <!--:model作用：可以使得el-form针对表单的全部信息进行收集，固定属性-->
          <el-form-item label="学科：">
            <el-select v-model="addForm.subjectID">
              <el-option
                v-for="item in subjectIDList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="目录：">
            <el-select v-model="addForm.catalogID">
              <el-option
                v-for="item in catalogIDList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="企业：">
            <el-select v-model="addForm.enterpriseID">
              <el-option
                v-for="item in enterpriseIDList"
                :key="item.id"
                :label="item.shortName"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="城市：">
            <el-select v-model="addForm.province" @change="addForm.city=''">
              <el-option v-for="(item,k) in provinces()" :key="k" :label="item" :value="item"></el-option>
            </el-select>
            <el-select v-model="addForm.city">
              <el-option
                v-for="(item,k) in citys(addForm.province)"
                :key="k"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="方向：">
            <el-select v-model="addForm.direction">
              <el-option v-for="item in directionList" :key="item" :value="item" :label="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="题型：">
            <!-- 
    el-radio小项目：label设置单选按钮的value值
    服务器端要求value的值是"字符串"的,所以item.value+'' 类型转换
            -->
            <el-radio-group v-model="addForm.questionType">
              <el-radio
                v-for="item in questionTypeList"
                :key="item.value"
                :label="item.value+''"
              >{{item.label}}</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="难度：">
            <el-radio-group v-model="addForm.difficulty">
              <el-radio
                v-for="item in difficultyList"
                :key="item.value"
                :label="item.value+''"
              >{{item.label}}</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="题干：">
            <el-input type="textarea" v-model="addForm.question"></el-input>
          </el-form-item>
          <el-form-item label="选项：" v-if="addForm.questionType!=='3'">
            <template v-if="addForm.questionType==='1'">
              <el-radio v-model="singleSelect" :label="0">
                A:
                <el-input type="text" v-model="addForm.options[0]['title']"></el-input>
              </el-radio>
              <br />
              <el-radio v-model="singleSelect" :label="1">
                B:
                <el-input type="text" v-model="addForm.options[1]['title']"></el-input>
              </el-radio>
              <br />
              <el-radio v-model="singleSelect" :label="2">
                C:
                <el-input type="text" v-model="addForm.options[2]['title']"></el-input>
              </el-radio>
              <br />
              <el-radio v-model="singleSelect" :label="3">
                D:
                <el-input type="text" v-model="addForm.options[3]['title']"></el-input>
              </el-radio>
            </template>
            <!-- 复选框 -->
            <template v-if="addForm.questionType==='2'">
              <el-checkbox v-model="addForm.options[0].isRight">
                A.
                <el-input v-model="addForm.options[0].title"></el-input>
              </el-checkbox>
              <br />
              <el-checkbox v-model="addForm.options[1].isRight">
                B.
                <el-input v-model="addForm.options[1].title"></el-input>
              </el-checkbox>
              <br />
              <el-checkbox v-model="addForm.options[2].isRight">
                C.
                <el-input v-model="addForm.options[2].title"></el-input>
              </el-checkbox>
              <br />
              <el-checkbox v-model="addForm.options[3].isRight">
                D.
                <el-input v-model="addForm.options[3].title"></el-input>
              </el-checkbox>
            </template>
          </el-form-item>
          <el-form-item label="答案：">
            <el-input type="textarea" v-model="addForm.answer"></el-input>
          </el-form-item>
          <el-form-item label="备注：">
            <el-input type="textarea" v-model="addForm.remarks"></el-input>
          </el-form-item>
          <el-form-item label="标签：">
            <el-input type="text" v-model="addForm.tags"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="tianjia()">提交</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
  </div>
</template>

<script>
// 添加
import { add } from '@/api/hmmm/questions.js'
// 企业
import { list as listCompanys } from '@/api/hmmm/companys'
import { simple as simpleSubjects } from '@/api/hmmm/subjects' // 学科
import { simple as simpleDirectorys } from '@/api/hmmm/directorys' // 二级目录
import { provinces, citys } from '@/api/hmmm/citys' // 城市和区县
// 常量(方向)
import {
  direction as directionList,
  questionType as questionTypeList,
  difficulty as difficultyList
} from '@/api/hmmm/constants'
export default {
  name: 'QuestionsNew',
  data() {
    return {
      difficultyList,
      questionTypeList,
      enterpriseIDList: [], // 企业
      subjectIDList: [], // 学科
      catalogIDList: [], // 二级目录
      directionList, // 方向(简易成员赋值)
      // 添加试题 表单数据对象
      singleSelect: '',
      addForm: {
        options: [
          // {code: '编号ABCD', title: '当前项目文字答案',
          //   img: '当前项目图片答案', isRight: boolean表明当前项目是否是答案},
          { code: 'A', title: '', img: '', isRight: false },
          { code: 'B', title: '', img: '', isRight: false },
          { code: 'C', title: '', img: '', isRight: false },
          { code: 'D', title: '', img: '', isRight: false }
        ],
        // 如下表单字段名称来自yapi数据接口
        difficulty: '1',
        questionType: '1',
        subjectID: '', // 学科
        catalogID: '', // 二级目录
        enterpriseID: '', // 企业
        city: '', // 区县
        province: '', // 城市
        direction: '', // 方向
        question: '', // 题干
        answer: '', // 答案
        remarks: '', // 备注
        tags: '', // 标签
        videoURL: 'http://www.xxx.com' // 解析视频
      }
    }
  },
  watch: {
    singleSelect(newV) {
      // 1. 先让全部项目都处于false不选中状态
      // newV的值和每一个options的索引相同
      for (var i = 0; i < 4; i++) {
        this.addForm.options[i].isRight = false
      }
      // 2. 当前选中项目的isRight为true
      this.addForm.options[newV].isRight = true
    }
  },
  created() {
    this.getEnterpriseIDList() // 获得企业
    this.getSubjectIDList() // 学科
    this.getCatalogIDList() // 二级目录
  },
  methods: {
    provinces, // 获得城市的方法provinces：provinces；
    citys, // 获得地区的方法
    async tianjia() {
      // await保证"异步"程序变为"同步"程序
      // await没有执行完毕，后续代码不要执行
      // 避免特殊情况：数据添加了，但是列表页面没有显示，
      //              而是再次添加时候，再把上次的添加数据给显示出来
      const result = await add(this.addForm)
      // 成功提示
      this.$message.success('添加试题成功')
      // 页面跳转--->列表页面
      this.$router.push('/questions/list')
    },
    async getEnterpriseIDList() {
      var result = await listCompanys()
      this.enterpriseIDList = result.data.items
    },
    // 学科
    async getSubjectIDList() {
      var result = await simpleSubjects()
      this.subjectIDList = result.data
    },
    // 目录
    async getCatalogIDList() {
      var result = await simpleDirectorys()
      this.catalogIDList = result.data
    }
  }
}
</script>

<style scoped>
</style>
