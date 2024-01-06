/* Script for converting /moving stuff. To be run in Deno */

import { default as papaparse } from "npm:papaparse@latest";
import { exists } from "https://deno.land/std/fs/mod.ts";

const decoder = new TextDecoder("utf-8");
const spreadsheet = "./texts-for-transcription.csv";
const DriveURL = "PATH_TO_DRIVE_URL";

const dataDir = "/Users/takeda/projects/wea_data/data";

const facsDir = "./facsimiles";
const textsDir = "./texts";

try {
  const stream = await Deno.readFile(spreadsheet);
  const text = decoder.decode(stream);
  const { data } = papaparse.parse(text, {
    header: true,
  });
  for await (const row of data) {
    row.id = getID(row);
    await convert(row);
  }
} catch (e) {
  console.error(e);
}

async function convert(row) {
  try {
    await copyPDF(row);
    await convertFile(row);
  } catch (e) {
    console.error(e);
  }
}

async function convertFile(row) {
  let inFile = `${dataDir}/addTextFromDrive/template.xm_`;
  row["isTemplate"] = true;
  const { id, WEA_ID_extant, WEA_ID_new } = row;
  if (WEA_ID_extant.length > 0) {
    inFile = `${dataDir}/texts/${WEA_ID_extant}.xml`;
    row["isTemplate"] = false;
  }
  const inFileExists = await exists(inFile, {
    isFile: true,
    isReadable: true,
  });
  if (!inFileExists) {
    console.error(`ERROR: ${inFile} does not exist`);
  }
  console.log(inFile);
  const outFile = `${textsDir}/${id}.xml`;
  await runXSLT(inFile, outFile, row);
}
async function copyPDF(row) {
  console.log(`Processing ${row.id}`);
  const dirExists = await exists(facsDir, {
    isDirectory: true,
    isReadable: true,
    isWritable: true,
  });
  console.log(dirExists);
  if (!dirExists) {
    await Deno.mkdir(facsDir);
  }
  const origFile = `${DriveURL}/${row.id}.pdf`;
  console.log(`Copying ${origFile}`);
  await Deno.copyFile(origFile, `${facsDir}/${row.id}.pdf`);
}

function getID(row) {
  const { WEA_ID_extant, WEA_ID_new } = row;
  if (WEA_ID_extant && WEA_ID_extant.length > 0) {
    return WEA_ID_extant;
  }
  return WEA_ID_new;
}

async function runXSLT(source, out, data) {
  const command = new Deno.Command("saxon", {
    args: [
      `-s:${source}`,
      `-xsl:convert.xsl`,
      `-o:${out}`,
      `data=${JSON.stringify(data)}`,
    ],
  });
  const { code, stdout, stderr } = await command.output();
  console.assert(code === 0);
  console.log(new TextDecoder().decode(stdout));
  if (code !== 0) {
    console.error(new TextDecoder().decode(stderr));
  }
  return code;
}
