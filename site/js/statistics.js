import * as echarts from "./echarts.esm.min.js";


class Viz {
  constructor(path = "../json/texts.json") {
    this.path = path;
    this.ctx = document.getElementById("echart");
    this.chart = echarts.init(this.ctx);
  }

  async init() {
    const json = await this.get(this.path);
    this.json = json;
    await this._setupProperties();
  }

  async _setupProperties() {
    this._setData();
    this._setYears();
    await this._setTaxonomies();
  }

  async _setTaxonomies() {
    const taxonomies = await this.get("../json/taxonomies.json");
    this.taxonomies = taxonomies;
    return true;
  }

  _setData() {
    this.data = Object.values(this.json).reduce((array, obj) => {
      const { pubDate } = obj;
      if (!pubDate) {
        return array;
      }
      const pubYear = parseInt(pubDate.split("-")[0]);
      obj["_pubYear"] = pubYear;
      array.push(obj);
      return array;
    }, []);
    return true;
  }

  _setYears() {
    if (this.years) {
      return this.years;
    }
    this.years = this.distinct(this.data.map((item) => item._pubYear));
    for (let i = Math.min(...this.years); i <= Math.max(...this.years); i++) {
      if (!this.years.includes(i)) {
        this.years.push(i);
      }
    }
    this.years.sort((a, b) => a - b);
    return true;
  }

  getOptions() {
    const self = this;
    return {
      aria: {
        enabled: true,
        decal: {
          show: true,
        },
      },
      tooltip: {
        trigger: "axis",
        confine: true,
      },
      toolbox: {
        feature: {
          dataView: { show: true, readOnly: false },
          magicType: { show: true, type: ["line", "bar", "pie"] },
          restore: { show: true },
          saveAsImage: { show: true },
        },
      },
      legend: {},
      xAxis: {
        name: "Year Published",
        type: "category",
        data: this.years,
        nameLocation: "middle",
        nameGap: 40,
        nameRotate: 0,
        nameTextStyle: {
          fontSize: 14,
          fontWeight: "bold",
        },
      },
      yAxis: {
        name: "Titles Published",
        type: "value",
        nameLocation: "middle",
        nameOrientation: "horizontal",
        nameGap: 40,
        nameTextStyle: {
          fontSize: 14,
          fontWeight: "bold",
        },
      },
      series: [],
    };
  }
  getTitlesSeries() {
    const grouped = this.groupByPubYear(this.data);
    const data = Object.values(grouped).map((a) => a.length);
    return [
      {
        data: Object.values(grouped).map((a) => a.length),
        type: "bar",
      },
    ];
  }

  async getGenreSeries() {
    const grouped = Object.groupBy(this.data, ({ genre }) => {
      if (!genre || genre.length === 0) {
        return undefined;
      }
      return this.isFiction(genre) ? "Fiction" : "Non-Fiction";
    });
    delete grouped.undefined;
    return Object.entries(grouped).map(([key, values]) => {
      const byYear = this.groupByPubYear(values);
      return {
        data: Object.values(byYear).map((a) => a.length),
        type: "bar",
        name: key,
        emphasis: {
          focus: "series",
        },
        stack: "texts",
      };
    });
  }

  async buildChart() {
    const options = this.getOptions();
    const series = await this.getGenreSeries();
    options.series = series;
    options.title = {
      text: "Published Texts by Genre",
      left: "center",
    };
    options.legend = {
      orient: "vertical",
      right: 0,
      top: "center",
    };
    this.chart.setOption(options);
    return this.chart;
  }

  groupByPubYear(items) {
    const obj = Object.groupBy(items, ({ _pubYear }) => {
      return _pubYear;
    });
    for (const year of this.years) {
      if (!obj[year]) {
        obj[year] = [];
      }
    }
    return obj;
  }

  debug(data) {
    console.log(data);
    document.querySelector("#json").data = data;
    return true;
  }

  distinct(array) {
    return [...new Set(array)];
  }

  isFiction(array) {
    return !array.some((i) => {
      console.log(i);
      const { parent } = this.taxonomies[i];
      return i === "genreNF" || parent === "genreNF";
    });
  }

  async get(path) {
    return await (await fetch(path)).json();
  }

  resize() {
    this.chart.resize();
  }
}

(async () => {
   document.querySelector(`#info + [data-el="div"]`).insertAdjacentHTML('afterbegin', `<div id="echart" class="echart"></div>`);
   const c = new Viz();
   await c.init();
   await c.buildChart();
   window.addEventListener("resize", function () {
        c.resize();
   });
   window.viz = c;
})();


