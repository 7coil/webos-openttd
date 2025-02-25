const fs = require("fs");
const fsp = require("fs/promises");
const crypto = require("crypto");
const stream = require("stream/promises");

const getSha256 = async (filename) => {
  const input = fs.createReadStream(filename);
  const hash = crypto.createHash("sha256");
  await stream.pipeline(input, hash);
  return hash.digest("hex");
};

const open = async (filename) =>
  new Promise((resolve, reject) => {
    fs.open(filename, "r", (error, fd) => {
      if (error) return reject(error);
      resolve(fd);
    });
  });

const fstat = async (fd) =>
  new Promise((resolve, reject) => {
    fs.fstat(fd, (error, stats) => {
      if (error) return reject(error);
      resolve(stats);
    });
  });


const getSize = async (filename) => {
  const fd = await open(filename);
  const appfileInfo = await fstat(fd);
  
  const getBytes = () => new Promise((resolve, reject) => {
    const size = Buffer.alloc(4, 0);
    fs.read(fd, size, 0, 4, appfileInfo.size - 4, (error, bytesRead) => {
      if (error) return reject(error);
      if (bytesRead !== 4) reject(new Error(`Read ${bytesRead} bytes instead of 4 bytes.`));
      resolve(size.readInt32LE(0));
    })
  })
  
  return {
    ipkSize: appfileInfo.size,
    installedSize: await getBytes(),
  };
};

const main = async () => {
  const appinfoText = await fsp.readFile("./public/appinfo.json", {
    encoding: "utf-8",
  });
  const appinfo = JSON.parse(appinfoText);
  const appfile = `${appinfo.id}_${appinfo.version}_arm.ipk`;
  const size = await getSize(appfile);

  const manifest = {
    id: appinfo.id,
    version: appinfo.version,
    type: appinfo.type,
    title: appinfo.title,
    appDescription: appinfo.appDescription,
    iconUri:
      "https://github.com/7coil/webos-openttd/raw/webos/os/webos/public/icon.png",
    sourceUrl: "https://github.com/7coil/webos-openttd",
    ipkUrl: `https://github.com/7coil/webos-openttd/releases/download/${appinfo.version}-webos/${appfile}`,
    ipkHash: {
      sha256: await getSha256(appfile),
    },
    ipkSize: size.ipkSize,
    installedSize: size.installedSize,
  };

  await fsp.writeFile("manifest.json", JSON.stringify(manifest, null, 2), {
    encoding: "utf-8",
  });
};

main();
