/** Script to compress facsimiles */

const facsDir = "./facsimiles";
const files = Deno.readDir(facsDir);
for await (const file of files) {
  const { name } = file;
  console.log(`Compressing ${name}`);
  const command = new Deno.Command("gs", {
    args: [
      "-sDEVICE=pdfwrite",
      "-dCompatibilityLevel=1.4",
      "-dPDFSETTINGS=/ebook",
      "-dNOPAUSE",
      "-dQUIET",
      "-dBATCH",
      `-sOutputFile=./compressed_facs/${name}`,
      `${facsDir}/${name}`,
    ],
  });
  const { code, stdout, stderr } = await command.output();
  console.assert(code === 0);
  console.log(new TextDecoder().decode(stdout));
  if (code !== 0) {
    console.error(new TextDecoder().decode(stderr));
  }
}
