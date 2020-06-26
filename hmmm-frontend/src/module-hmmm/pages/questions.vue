<template>
  <div class="dashboard-container">
    <div class="app-container">
      <el-card class="box-card">
        <el-row>
          <el-col>
            <el-button
              type="primary"
              size="mini"
              @click="$router.push('/questions/new')"
            >{{$t('question.newadd')}}</el-button>
            <el-button type="danger" size="mini">{{$t('question.manyadd')}}</el-button>
          </el-col>
        </el-row>
        <!-- gutter给列设置间距，单位像素 -->
        <el-row :gutter="20">
          <!-- span设置各个列占据的宽度，单位是“权”，总数为24 -->
          <el-col :span="6">
            学科：
            <!-- 没有数据数据的时候,el-option不要设置，会报错 -->
            <el-select v-model="searchForm.subjectID" placeholder="请选择" class="wd">
              <el-option
                v-for="item in subjectIDList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            难度：
            <el-select v-model="searchForm.difficuly" placeholder="请选择" class="wd">
              <el-option
                v-for="item in difficultyList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            试题类型：
            <el-select v-model="searchForm.questionType" placeholder="请选择" class="wd">
              <el-option
                v-for="item in questionTypeList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;签:
            <el-option
              v-for="item in tagsList"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="6">
            城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：
            <el-select
              v-model="searchForm.province"
              placeholder="选城市"
              style="width:85px;"
              @change="searchForm.city=''"
            >
              <el-option v-for="(item,k) in provinces()" :key="k" :label="item" :value="item"></el-option>
            </el-select>
            <el-select v-model="searchForm.city" placeholder="选区县" style="width:85px;">
              <el-option
                v-for="(item,k) in citys(searchForm.province)"
                :key="k"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            关&nbsp;键&nbsp;字：
            <el-input type="text" v-model="searchForm.keyword" class="wd"></el-input>
          </el-col>
          <el-col :span="6">
            题目备注：
            <el-input type="text" v-model="searchForm.remarks" class="wd"></el-input>
          </el-col>
          <el-col :span="6">
            企业简称：
            <el-input type="text" v-model="searchForm.shortName" class="wd"></el-input>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="6">
            方&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;向：
            <el-select v-model="searchForm.direction" placeholder="请选择" class="wd">
              <el-option v-for="(item,k) in directionList" :key="k" :value="item" :label="item"></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            录&nbsp;入&nbsp;人：
            <el-select v-model="searchForm.creatorID" placeholder="请选择" class="wd">
              <el-option
                v-for="item in creatorIDList"
                :key="item.id"
                :label="item.username"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            二级目录：
            <el-select v-model="searchForm.catalogID" placeholder="请选择" class="wd">
              <el-option
                v-for="item in catalogIDList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="6">
            <el-button size="mini">清除</el-button>
            <el-button type="primary" size="mini">搜索</el-button>
          </el-col>
        </el-row>
        <!-- 列表 -->
        <el-table :data="questionList" style="width:100%">
          <el-table-column label="序号" type="index" width="60"></el-table-column>
          <el-table-column label="试题编号" prop="number"></el-table-column>
          <el-table-column label="学科" prop="subject"></el-table-column>
          <el-table-column label="题型" prop="questionType" :formatter="questionTypeFMT"></el-table-column>
          <el-table-column label="题干" prop="question"></el-table-column>
          <el-table-column label="录入时间" prop="addDate" width="170">
            <template slot-scope="stData">
              <!-- stData.row 获取到当前遍历后的每个题库记录信息，是对象-->
              <!-- 过滤器使用可以传递参数 -->
              {{stData.row.addDate | parseTimeByString}}
              <!--年月日时分秒-->
              <!--{{stData.row.addDate | parseTimeByString('{y}-{m}-{d}')}} 年月日-->
            </template>
          </el-table-column>
          <el-table-column label="难度" prop="difficulty" :formatter="difficultyFMT"></el-table-column>
          <el-table-column label="录入人" prop="creator"></el-table-column>
          <el-table-column label="操作" width="200">
            <template slot-scope="stData">
              <a href="#">预览</a>
              <a href="#">修改</a>
              <a href="#" @click.prevent="del(stData.row)">删除</a>
              <a href="#">加入精选</a>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="searchForm.page"
          :page-sizes="[3, 5, 10, 20]"
          :page-size="searchForm.pagesize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="tot"
        ></el-pagination>
      </el-card>
    </div>
  </div>
</template>

<script>
// 列表// 删除
import { list, remove } from '@/api/hmmm/questions.js'
// 城市  县区
import { provinces, citys } from '@/api/hmmm/citys'
// 方向
import { direction as directionList } from '@/api/hmmm/constants.js'
// 二级目录
import { simple as simpleDirectorys } from '@/api/hmmm/directorys.js'
// 录入人
import { simple as simpleUsers } from '@/api/base/users.js'
// 标签
import { simple as simpleTags } from '@/api/hmmm/tags.js'
import {
  difficulty as difficultyList,
  questionType as questionTypeList
} from '@/api/hmmm/constants.js'
import { simple } from '@/api/hmmm/subjects.js'
export default {
  name: 'QuestionsList',
  data() {
    return {
      directionList,
      difficultyList,
      questionTypeList,
      questionList: [],
      catalogIDList: [],
      creatorIDList: [],
      tagsList: [],
      subjectIDList: [],
      tot: 0, // 数据总条数
      // 创建搜索表单对象
      searchForm: {
        // 名称来自api接口
        page: 1, // 默认获取第1页数据
        pagesize: 3, // 默认每页获得3条数据
        subjectID: '', // 学科
        difficuly: '', // 难度
        questionType: '', // 题型
        tags: '', // 标签
        province: '', // 城市
        city: '', // 区县
        keyword: '', // 关键字
        remarks: '', // 备注
        shortName: '', // 企业简称
        direction: '', // 方向
        creatorID: '', // 录入人
        catalogID: '' // 二级目录
      }
    }
  },
  created() {
    this.getQuestionList()
    this.getCatalogIDList()
    this.getCreatorIDList()
    this.getTagsList()
    this.getSubjectIDList()
  },
  watch: {
    // 对 searchForm 成员做深度监听:能够监听到最深层
    searchForm: {
      handler: function(newV) {
        // 根据变化后的条件重新获得题库列表
        this.getQuestionList()
      },
      deep: true
    }
  },
  methods: {
    handleSizeChange(val) {
      // console.log(val)
      // 把val赋值给searchForm.pagesize成员--->watch--->getQuestionList-->list(this.searchForm)
      this.searchForm.pagesize = val
    },
    // 分页-当前页码变化的回调处理
    // 参数val:变化后的页码数据
    handleCurrentChange(val) {
      // 把val赋值给searchForm.page成员--->watch--->getQuestionList-->list(this.searchForm)
      this.searchForm.page = val
    },
    del(question) {
      // 确认框
      this.$confirm('确认要删除该试题么?', '删除', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
        .then(async () => {
          // 确定的逻辑(async需要设置到await外边最近的function前边)
          const result = await remove(question)
          // 成功提示
          this.$message.success('删除成功！')
          // 数据刷新
          this.getQuestionList()
        })
        .catch(() => {
          // 取消逻辑
        })
    },
    async getQuestionList() {
      // 把查询数据的条件当参数配置给list方法
      const result = await list(this.searchForm)
      this.questionList = result.data.items
      this.tot = rst.data.counts
    },
    difficultyFMT(row, column, cellValue) {
      return this.difficultyList[cellValue - 1].label
    },
    // row:代表当前的各个题库的记录信息
    // column：数据记录列的信息
    // cellValue：当前正在被处理的列的单元信息
    // index：代表各个立即的序号信息，从0开始计数
    questionTypeFMT(row, column, cellValue, index) {
      // cellValue=1  -----> 单选--->下标0[cellValue-1]
      // cellValue=2  -----> 多选--->下标1[cellValue-1]
      // cellValue=3  -----> 简答--->下标2[cellValue-1]
      return this.questionTypeList[cellValue - 1].label
    },
    provinces, // provinces:provinces
    citys, // citys:citys
    async getSubjectIDList() {
      const result = await simple()
      this.subjectIDList = result.data
    },
    // 标签
    async getTagsList() {
      var result = await simpleTags() // Promise对象 变为 dt了
      this.tagsList = result.data
    },
    async getCreatorIDList() {
      var result = await simpleUsers()
      this.creatorIDList = result.data
    },
    async getCatalogIDList() {
      var result = await simpleDirectorys()
      this.catalogIDList = result.data
    },
    async getQuestionList() {
      var result = await list()
      this.questionList = result.data.items
    }
  }
}
</script>

<style scoped>
.wd {
  width: 170px;
}
.el-row {
  margin-bottom: 10px;
}
.el-table {
  margin-top: 25px;
}
.el-pagination {
  margin-top: 15px;
}
</style>
