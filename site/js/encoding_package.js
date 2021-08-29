
//var circle = document.querySelector('circle');




class Zipper{
    constructor(){
        this.map = new Map();
        this.list = document.querySelector('#contribute_package_texts');
        this.extensions = ['xml', 'pdf'];
        this.setup();
        
    }

    get inputs(){
        return [...this.list.querySelectorAll('input')];
    }

    get ids(){
           return this.inputs.filter(inp => inp.checked).map(input => input.id);
    }
    
    set progress(num){
        this.downloadBtn.style.setProperty('--download-btn-offset', `${num}%`);
        if (num >= 100){
            this.downloadBtn.classList.remove('active');
            this.downloadBtn.style.removeProperty('--download-btn-offset');
        }
    }
    
    setup(){
        let self = this;

        this.downloadBtn = document.createElement('button');
        this.downloadBtn.innerHTML = `<span>Download</span>`;
        this.list.appendChild(this.downloadBtn);
        this.downloadBtn.classList.add('download_btn');
        this.downloadBtn.disabled = true;
        this.downloadBtn.addEventListener('click', this.downloadZip.bind(this));
        this.inputs.forEach(input => {
            input.addEventListener('change', e=> {
                input.parentNode.classList.toggle('selected');
                self.downloadBtn.disabled = self.ids.length == 0;
            });
 
        });
    }
    
    async baseZip(){
        this.zip = new JSZip();
        let src = await fetch('encoding_package.zip');
        this.zip.loadAsync(await src.blob());
        return true;
    }

    async downloadZip(e){
        this.downloadBtn.classList.add('active');
        await this.makeZip();
        console.log('Blobbing!');
        const blob = await this.zip.generateAsync({type: 'blob'}, this.reportProgress.bind(this));
        console.log('Blobbing finished');
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = `wea_${this.ids.join('_')}.zip`;
        link.click();
        URL.revokeObjectURL(link.href);
        await this.baseZip();
    }


    reportProgress(metadata){
        this.progress = metadata.percent.toFixed(2);
    }

    async makeZip(){
        let self = this;
        await this.baseZip();
        for (const id of this.ids){
            console.log('Processing ' + id);
            await Promise.all(this.extensions.map(x => {
                return new Promise(async (resolve, reject) => {
                    let inDir = x == 'xml' ? 'xml/original' : 'facsimiles';
                    let outDir = x == 'xml' ? 'texts' : 'facsimiles';
                    const doc = await fetch(`${inDir}/${id}.${x}`);
                    const result = await (x == 'xml' ? doc.text() : doc.blob());
                    let out = `${outDir}/${id}.${x}`;
                    resolve(self.zip.file(out, result));
                })
            }));
        }
        return true;
    }

    async showZip(){
        await this.makeZip();
        console.log(this.zip);
    }
}

document.addEventListener('DOMContentLoaded', e => {
    if (document.documentElement.id == 'contribute'){
        let z = new Zipper();   
    }
});






