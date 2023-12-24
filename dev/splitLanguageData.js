const fs = require("fs");
const data = require("./data.js");

// const data = JSON.parse(fs.readFileSync(__dirname + "/data.json", "utf8"));

const zh_Hans = [];

const zh_Hant = [];

// const en = [];

data.forEach((item) => {
  zh_Hans.push(item[1]);
  zh_Hant.push(item[2]);
  //   en.push({
  //     key: item[0],
  //     value: item[3],
  //   });
});

fs.writeFileSync(
  __dirname + "/../assets/zh_Hans.json",
  JSON.stringify(zh_Hans)
);
fs.writeFileSync(
  __dirname + "/../assets/zh_Hant.json",
  JSON.stringify(zh_Hant)
);
