 class Accordion {
    constructor(el) {
        try{
            // Store the <details> element
            this.el = el;

            // Store the <summary> element
            this.summary = el.querySelector('summary');

            // Store the <div class="content"> element
            this.content = el.querySelector('.content') || this.makeContent();

            // Store the animation object (so we can cancel it if needed)
            this.animation = null;

            //It's not doing anything at the moment.
            this.state = [0];

            // Create configuration for easing function;
            this.easing = this.getCustomProp('easing', 'ease-in-out');

            // Create an option for timing
            this.duration = this.convertDuration(this.getCustomProp('duration', '400').trim());

            // Make the heights
            this.startHeight = null;
            this.endHeight = null;

            // Now init the actual element stuff
            this.init();

        } catch(e){
            console.log(`${e}`);
        }
    }

    init() {
        // Set the aria role
        this.el.setAttribute('aria-expanded', this.el.open);
        // Add a class to the element
        this.el.classList.add('accordion');
        // Detect user clicks on the summary element
        this.summary.addEventListener('click', (e) => this.onClick(e));
    }

    // Function to get custom properties
    // so to align any duration/easing stuff in the CSS
    // This can be overridden by the object declaration, however
    getCustomProp(prop, defaultVal) {
        //Get the actual declaration;
        let propDecl = `--accordion-${prop}`;
        //Get the computed style
        let style = getComputedStyle(this.el);
        //Get the property value
        let propVal = style.getPropertyValue(propDecl);
        return (propVal) ? propVal : defaultVal;
    }

    // Create the click listener
    onClick(e) {
        // Stop default behaviour from the browser
        e.preventDefault();

        // Add an overflow on the <details> to avoid content overflowing
        this.el.style.overflow = 'hidden';

        //Prevent any further clicking from happening
        this.el.style.pointerEvents = 'none';

        // Check if the element is being closed or is already closed
        if (!this.el.open) {
            this.open();
            // Check if the element is being opened or is already open
        } else {
            this.close();
        }
    }

    makeContent() {
        let nodes = [...this.el.childNodes].filter(n => !n.isSameNode(this.summary));
        let div = document.createElement('div');
        div.classList.add('accordion__content');
        nodes.forEach(node => div.appendChild(node));
        this.el.appendChild(div);
        return div;
    }

    open() {
        // Apply a fixed height on the element
        this.el.style.height = `${this.el.offsetHeight}px`;
        // Force the [open] attribute on the details element
        this.el.open = true;
        // Wait for the next frame to call the expand function
        window.requestAnimationFrame(() => this.expand());
    }

    close() {
        //Add the aria label
        window.requestAnimationFrame(() => this.shrink());
    }

    expand() {
        // Set the element as "being expanding"
        this.state.push(1);
        // Get the current fixed height of the element
        this.startHeight = `${this.el.offsetHeight}px`;
        // Calculate the open height of the element (summary height + content height)
        this.endHeight = `${this.summary.offsetHeight + this.content.offsetHeight}px`;
        this.el.setAttribute('aria-expanded', 'true');
        //Now animate
        this.animate();
    }

    shrink() {
        // Set the element as "being closed"
        this.state.push(-1);
        // Store the current height of the element
        this.startHeight = `${this.el.offsetHeight}px`;
        // Calculate the height of the summary
        this.endHeight = `${this.summary.offsetHeight}px`;
        this.el.setAttribute('aria-expanded', 'false');
        this.animate();
    }

    animate() {
        // If there is already an animation running
        if (this.animation) {
            // Cancel the current animation
            this.animation.cancel();
        }

        // Start a WAAPI animation
        this.animation = this.el.animate({
            // Set the keyframes from the startHeight to endHeight
            height: [this.startHeight, this.endHeight]
        }, {
            duration: this.duration,
            easing: this.easing
        });

        // When the animation is complete, call onAnimationFinish()
        this.animation.onfinish = () => this.onAnimationFinish();
        // If the animation is cancelled, isExpanding variable is set to false
        this.animation.oncancel = () => this.state.slice(0, 1);
    }

    onAnimationFinish() {
        // Set the open attribute based on the parameter
        this.el.open = this.state[1] > 0;
        // Clear the stored animation
        this.animation = null;
        // Reset state
        this.state = [0];
        this.startHeight = this.endHeight = null;
        // Remove the overflow hidden and the fixed height
        this.el.style.height = this.el.style.overflow = '';
        this.el.style.pointerEvents = 'auto';
    }

    convertDuration(dur) {
        if (/[\d]s$/g.test(dur)){
            return parseFloat(dur) * 1000;
        } else {
            parseInt(dur, 10);
        }
    }
}

 
 
 let accordions = [...document.querySelectorAll('details')].map(dtl => {
        return new Accordion(dtl);
    });